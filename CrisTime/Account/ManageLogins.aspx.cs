// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.ManageLogins
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using CrisTime.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Account
{
  public class ManageLogins : Page
  {
    protected PlaceHolder successMessage;

    protected string SuccessMessage { get; private set; }

    protected bool CanRemoveExternalLogins { get; private set; }

    private bool HasPassword(ApplicationUserManager manager)
    {
      return manager.HasPassword<ApplicationUser, string>(this.User.Identity.GetUserId());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      this.CanRemoveExternalLogins = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>().GetLogins<ApplicationUser, string>(this.User.Identity.GetUserId()).Count<UserLoginInfo>() > 1;
      this.SuccessMessage = string.Empty;
      this.successMessage.Visible = !string.IsNullOrEmpty(this.SuccessMessage);
    }

    public IEnumerable<UserLoginInfo> GetLogins()
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      IList<UserLoginInfo> logins = userManager.GetLogins<ApplicationUser, string>(this.User.Identity.GetUserId());
      this.CanRemoveExternalLogins = logins.Count<UserLoginInfo>() > 1 || this.HasPassword(userManager);
      return (IEnumerable<UserLoginInfo>) logins;
    }

    public void RemoveLogin(string loginProvider, string providerKey)
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      ApplicationSignInManager manager = this.Context.GetOwinContext().Get<ApplicationSignInManager>();
      IdentityResult identityResult = userManager.RemoveLogin<ApplicationUser, string>(this.User.Identity.GetUserId(), new UserLoginInfo(loginProvider, providerKey));
      string str = string.Empty;
      if (identityResult.Succeeded)
      {
        ApplicationUser byId = userManager.FindById<ApplicationUser, string>(this.User.Identity.GetUserId());
        manager.SignIn<ApplicationUser, string>(byId, false, false);
        str = "?m=RemoveLoginSuccess";
      }
      this.Response.Redirect("~/Account/ManageLogins" + str);
    }
  }
}
