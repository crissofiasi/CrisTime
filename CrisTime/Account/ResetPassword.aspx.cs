// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.ResetPassword
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
  public class ResetPassword : Page
  {
    protected Literal ErrorMessage;
    protected TextBox Email;
    protected TextBox Password;
    protected TextBox ConfirmPassword;

    protected string StatusMessage { get; private set; }

    protected void Reset_Click(object sender, EventArgs e)
    {
      string codeFromRequest = IdentityHelper.GetCodeFromRequest(this.Request);
      if (codeFromRequest != null)
      {
        ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
        ApplicationUser byName = userManager.FindByName<ApplicationUser, string>(this.Email.Text);
        if (byName == null)
        {
          this.ErrorMessage.Text = "No user found";
        }
        else
        {
          IdentityResult identityResult = userManager.ResetPassword<ApplicationUser, string>(byName.Id, codeFromRequest, this.Password.Text);
          if (identityResult.Succeeded)
            this.Response.Redirect("~/Account/ResetPasswordConfirmation");
          else
            this.ErrorMessage.Text = identityResult.Errors.FirstOrDefault<string>();
        }
      }
      else
        this.ErrorMessage.Text = "An error has occurred";
    }
  }
}
