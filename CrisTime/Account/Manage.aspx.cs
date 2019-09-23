// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.Manage
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using CrisTime.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.Owin.Security;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Account
{
  public class Manage : Page
  {
    protected PlaceHolder successMessage;
    protected HyperLink ChangePassword;
    protected HyperLink CreatePassword;
    protected Label PhoneNumber;

    protected string SuccessMessage { get; private set; }

    public bool HasPhoneNumber { get; private set; }

    public bool TwoFactorEnabled { get; private set; }

    public bool TwoFactorBrowserRemembered { get; private set; }

    public int LoginsCount { get; set; }

    private bool HasPassword(ApplicationUserManager manager)
    {
      return manager.HasPassword<ApplicationUser, string>(this.User.Identity.GetUserId());
    }

    protected void Page_Load()
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      this.HasPhoneNumber = string.IsNullOrEmpty(userManager.GetPhoneNumber<ApplicationUser, string>(this.User.Identity.GetUserId()));
      this.TwoFactorEnabled = userManager.GetTwoFactorEnabled<ApplicationUser, string>(this.User.Identity.GetUserId());
      this.LoginsCount = userManager.GetLogins<ApplicationUser, string>(this.User.Identity.GetUserId()).Count;
      IAuthenticationManager authentication = HttpContext.Current.GetOwinContext().Authentication;
      if (this.IsPostBack)
        return;
      if (this.HasPassword(userManager))
      {
        this.ChangePassword.Visible = true;
      }
      else
      {
        this.CreatePassword.Visible = true;
        this.ChangePassword.Visible = false;
      }
      string str = this.Request.QueryString["m"];
      if (str == null)
        return;
      this.Form.Action = this.ResolveUrl("~/Account/Manage");
      this.SuccessMessage = str == "ChangePwdSuccess" ? "Your password has been changed." : (str == "SetPwdSuccess" ? "Your password has been set." : (str == "RemoveLoginSuccess" ? "The account was removed." : (str == "AddPhoneNumberSuccess" ? "Phone number has been added" : (str == "RemovePhoneNumberSuccess" ? "Phone number was removed" : string.Empty))));
      this.successMessage.Visible = !string.IsNullOrEmpty(this.SuccessMessage);
    }

    private void AddErrors(IdentityResult result)
    {
      foreach (string error in result.Errors)
        this.ModelState.AddModelError("", error);
    }

    protected void RemovePhone_Click(object sender, EventArgs e)
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      ApplicationSignInManager manager = this.Context.GetOwinContext().Get<ApplicationSignInManager>();
      if (!userManager.SetPhoneNumber<ApplicationUser, string>(this.User.Identity.GetUserId(), (string) null).Succeeded)
        return;
      ApplicationUser byId = userManager.FindById<ApplicationUser, string>(this.User.Identity.GetUserId());
      if (byId == null)
        return;
      manager.SignIn<ApplicationUser, string>(byId, false, false);
      this.Response.Redirect("/Account/Manage?m=RemovePhoneNumberSuccess");
    }

    protected void TwoFactorDisable_Click(object sender, EventArgs e)
    {
      this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>().SetTwoFactorEnabled<ApplicationUser, string>(this.User.Identity.GetUserId(), false);
      this.Response.Redirect("/Account/Manage");
    }

    protected void TwoFactorEnable_Click(object sender, EventArgs e)
    {
      this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>().SetTwoFactorEnabled<ApplicationUser, string>(this.User.Identity.GetUserId(), true);
      this.Response.Redirect("/Account/Manage");
    }
  }
}
