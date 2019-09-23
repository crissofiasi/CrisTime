// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.Login
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using CrisTime.Models;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Account
{
  public class Login : Page
  {
    protected PlaceHolder ErrorMessage;
    protected Literal FailureText;
    protected TextBox id;
    protected TextBox Password;
    protected CheckBox RememberMe;
    protected HyperLink RegisterHyperLink;
    protected OpenAuthProviders OpenAuthLogin;

    protected void Page_Load(object sender, EventArgs e)
    {
      this.RegisterHyperLink.NavigateUrl = "Register";
      this.OpenAuthLogin.ReturnUrl = this.Request.QueryString["ReturnUrl"];
      string str = HttpUtility.UrlEncode(this.Request.QueryString["ReturnUrl"]);
      if (string.IsNullOrEmpty(str))
        return;
      HyperLink registerHyperLink = this.RegisterHyperLink;
      registerHyperLink.NavigateUrl = registerHyperLink.NavigateUrl + "?ReturnUrl=" + str;
    }

    protected void LogIn(object sender, EventArgs e)
    {
      if (!this.IsValid)
        return;
      this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      switch (this.Context.GetOwinContext().GetUserManager<ApplicationSignInManager>().PasswordSignIn<ApplicationUser, string>(this.id.Text, this.Password.Text, this.RememberMe.Checked, false))
      {
        case SignInStatus.Success:
          IdentityHelper.RedirectToReturnUrl(this.Request.QueryString["ReturnUrl"], this.Response);
          break;
        case SignInStatus.LockedOut:
          this.Response.Redirect("/Account/Lockout");
          break;
        case SignInStatus.RequiresVerification:
          this.Response.Redirect(string.Format("/Account/TwoFactorAuthenticationSignIn?ReturnUrl={0}&RememberMe={1}", (object) this.Request.QueryString["ReturnUrl"], (object) this.RememberMe.Checked), true);
          break;
        default:
          this.FailureText.Text = "Invalid login attempt";
          this.ErrorMessage.Visible = true;
          break;
      }
    }
  }
}
