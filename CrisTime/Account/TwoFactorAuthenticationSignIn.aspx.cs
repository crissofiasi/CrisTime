// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.TwoFactorAuthenticationSignIn
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
  public class TwoFactorAuthenticationSignIn : Page
  {
    private ApplicationSignInManager signinManager;
    private ApplicationUserManager manager;
    protected PlaceHolder sendcode;
    protected DropDownList Providers;
    protected Button ProviderSubmit;
    protected PlaceHolder verifycode;
    protected HiddenField SelectedProvider;
    protected PlaceHolder ErrorMessage;
    protected Literal FailureText;
    protected TextBox Code;
    protected CheckBox RememberBrowser;
    protected Button CodeSubmit;

    public TwoFactorAuthenticationSignIn()
    {
      this.manager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      this.signinManager = this.Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      string verifiedUserId = this.signinManager.GetVerifiedUserId<ApplicationUser, string>();
      if (verifiedUserId == null)
        this.Response.Redirect("/Account/Error", true);
      this.Providers.DataSource = (object) this.manager.GetValidTwoFactorProviders<ApplicationUser, string>(verifiedUserId).Select<string, string>((Func<string, string>) (x => x)).ToList<string>();
      this.Providers.DataBind();
    }

    protected void CodeSubmit_Click(object sender, EventArgs e)
    {
      bool result = false;
      bool.TryParse(this.Request.QueryString["RememberMe"], out result);
      switch (this.signinManager.TwoFactorSignIn<ApplicationUser, string>(this.SelectedProvider.Value, this.Code.Text, result, this.RememberBrowser.Checked))
      {
        case SignInStatus.Success:
          IdentityHelper.RedirectToReturnUrl(this.Request.QueryString["ReturnUrl"], this.Response);
          break;
        case SignInStatus.LockedOut:
          this.Response.Redirect("/Account/Lockout");
          break;
        default:
          this.FailureText.Text = "Invalid code";
          this.ErrorMessage.Visible = true;
          break;
      }
    }

    protected void ProviderSubmit_Click(object sender, EventArgs e)
    {
      if (!this.signinManager.SendTwoFactorCode<ApplicationUser, string>(this.Providers.SelectedValue))
        this.Response.Redirect("/Account/Error");
      ApplicationUser byId = this.manager.FindById<ApplicationUser, string>(this.signinManager.GetVerifiedUserId<ApplicationUser, string>());
      if (byId != null)
        this.manager.GenerateTwoFactorToken<ApplicationUser, string>(byId.Id, this.Providers.SelectedValue);
      this.SelectedProvider.Value = this.Providers.SelectedValue;
      this.sendcode.Visible = false;
      this.verifycode.Visible = true;
    }
  }
}
