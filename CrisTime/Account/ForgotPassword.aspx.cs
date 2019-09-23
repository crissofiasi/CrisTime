// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.ForgotPassword
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
  public class ForgotPassword : Page
  {
    protected PlaceHolder loginForm;
    protected PlaceHolder ErrorMessage;
    protected Literal FailureText;
    protected TextBox Email;
    protected PlaceHolder DisplayEmail;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void Forgot(object sender, EventArgs e)
    {
      if (!this.IsValid)
        return;
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      ApplicationUser byName = userManager.FindByName<ApplicationUser, string>(this.Email.Text);
      if (byName == null || !userManager.IsEmailConfirmed<ApplicationUser, string>(byName.Id))
      {
        this.FailureText.Text = "The user either does not exist or is not confirmed.";
        this.ErrorMessage.Visible = true;
      }
      else
      {
        this.loginForm.Visible = false;
        this.DisplayEmail.Visible = true;
      }
    }
  }
}
