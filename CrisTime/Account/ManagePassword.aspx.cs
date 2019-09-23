// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.ManagePassword
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using CrisTime.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Account
{
  public class ManagePassword : Page
  {
    protected PlaceHolder setPassword;
    protected TextBox password;
    protected TextBox confirmPassword;
    protected PlaceHolder changePasswordHolder;
    protected Label CurrentPasswordLabel;
    protected TextBox CurrentPassword;
    protected Label NewPasswordLabel;
    protected TextBox NewPassword;
    protected Label ConfirmNewPasswordLabel;
    protected TextBox ConfirmNewPassword;

    protected string SuccessMessage { get; private set; }

    private bool HasPassword(ApplicationUserManager manager)
    {
      return manager.HasPassword<ApplicationUser, string>(this.User.Identity.GetUserId());
    }

    protected void Page_Load(object sender, EventArgs e)
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      if (this.IsPostBack)
        return;
      if (this.HasPassword(userManager))
      {
        this.changePasswordHolder.Visible = true;
      }
      else
      {
        this.setPassword.Visible = true;
        this.changePasswordHolder.Visible = false;
      }
      if (this.Request.QueryString["m"] == null)
        return;
      this.Form.Action = this.ResolveUrl("~/Account/Manage");
    }

    protected void ChangePassword_Click(object sender, EventArgs e)
    {
      if (!this.IsValid)
        return;
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      ApplicationSignInManager manager = this.Context.GetOwinContext().Get<ApplicationSignInManager>();
      IdentityResult result = userManager.ChangePassword<ApplicationUser, string>(this.User.Identity.GetUserId(), this.CurrentPassword.Text, this.NewPassword.Text);
      if (result.Succeeded)
      {
        ApplicationUser byId = userManager.FindById<ApplicationUser, string>(this.User.Identity.GetUserId());
        manager.SignIn<ApplicationUser, string>(byId, false, false);
        this.Response.Redirect("~/Account/Manage?m=ChangePwdSuccess");
      }
      else
        this.AddErrors(result);
    }

    protected void SetPassword_Click(object sender, EventArgs e)
    {
      if (!this.IsValid)
        return;
      IdentityResult result = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>().AddPassword<ApplicationUser, string>(this.User.Identity.GetUserId(), this.password.Text);
      if (result.Succeeded)
        this.Response.Redirect("~/Account/Manage?m=SetPwdSuccess");
      else
        this.AddErrors(result);
    }

    private void AddErrors(IdentityResult result)
    {
      foreach (string error in result.Errors)
        this.ModelState.AddModelError("", error);
    }
  }
}
