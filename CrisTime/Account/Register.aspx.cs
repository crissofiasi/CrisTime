// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.Register
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using CrisTime.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Account
{
  public class Register : Page
  {
    protected Literal ErrorMessage;
    protected TextBox Email;
    protected TextBox Password;
    protected TextBox ConfirmPassword;

    protected void CreateUser_Click(object sender, EventArgs e)
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      this.Context.GetOwinContext().Get<ApplicationSignInManager>();
      ApplicationUser applicationUser = new ApplicationUser();
      string str = this.Email.Text + "_neverificat";
      applicationUser.UserName = str;
      string text1 = this.Email.Text;
      applicationUser.Email = text1;
      ApplicationUser user = applicationUser;
      string text2 = this.Password.Text;
      IdentityResult identityResult = userManager.Create<ApplicationUser, string>(user, text2);
      if (identityResult.Succeeded)
        IdentityHelper.RedirectToReturnUrl(this.Request.QueryString["ReturnUrl"], this.Response);
      else
        this.ErrorMessage.Text = identityResult.Errors.FirstOrDefault<string>();
    }
  }
}
