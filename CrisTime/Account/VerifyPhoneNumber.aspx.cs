// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.VerifyPhoneNumber
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
  public class VerifyPhoneNumber : Page
  {
    protected Literal ErrorMessage;
    protected HiddenField PhoneNumber;
    protected TextBox Code;

    protected void Page_Load(object sender, EventArgs e)
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      string str = this.Request.QueryString["PhoneNumber"];
      string userId = this.User.Identity.GetUserId();
      string phoneNumber = str;
      userManager.GenerateChangePhoneNumberToken<ApplicationUser, string>(userId, phoneNumber);
      this.PhoneNumber.Value = str;
    }

    protected void Code_Click(object sender, EventArgs e)
    {
      if (!this.ModelState.IsValid)
      {
        this.ModelState.AddModelError("", "Invalid code");
      }
      else
      {
        ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
        ApplicationSignInManager manager = this.Context.GetOwinContext().Get<ApplicationSignInManager>();
        if (userManager.ChangePhoneNumber<ApplicationUser, string>(this.User.Identity.GetUserId(), this.PhoneNumber.Value, this.Code.Text).Succeeded)
        {
          ApplicationUser byId = userManager.FindById<ApplicationUser, string>(this.User.Identity.GetUserId());
          if (byId != null)
          {
            manager.SignIn<ApplicationUser, string>(byId, false, false);
            this.Response.Redirect("/Account/Manage?m=AddPhoneNumberSuccess");
          }
        }
        this.ModelState.AddModelError("", "Failed to verify phone");
      }
    }
  }
}
