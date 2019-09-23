// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.AddPhoneNumber
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
  public class AddPhoneNumber : Page
  {
    protected Literal ErrorMessage;
    protected TextBox PhoneNumber;

    protected void PhoneNumber_Click(object sender, EventArgs e)
    {
      ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      string phoneNumberToken = userManager.GenerateChangePhoneNumberToken<ApplicationUser, string>(this.User.Identity.GetUserId(), this.PhoneNumber.Text);
      if (userManager.SmsService != null)
      {
        IdentityMessage message = new IdentityMessage()
        {
          Destination = this.PhoneNumber.Text,
          Body = "Your security code is " + phoneNumberToken
        };
        userManager.SmsService.Send(message);
      }
      this.Response.Redirect("/Account/VerifyPhoneNumber?PhoneNumber=" + HttpUtility.UrlEncode(this.PhoneNumber.Text));
    }
  }
}
