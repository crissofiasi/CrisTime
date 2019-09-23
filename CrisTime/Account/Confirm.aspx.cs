// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.Confirm
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
  public class Confirm : Page
  {
    protected PlaceHolder successPanel;
    protected HyperLink login;
    protected PlaceHolder errorPanel;

    protected string StatusMessage { get; private set; }

    protected void Page_Load(object sender, EventArgs e)
    {
      string codeFromRequest = IdentityHelper.GetCodeFromRequest(this.Request);
      string userIdFromRequest = IdentityHelper.GetUserIdFromRequest(this.Request);
      if (codeFromRequest != null && userIdFromRequest != null && this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>().ConfirmEmail<ApplicationUser, string>(userIdFromRequest, codeFromRequest).Succeeded)
      {
        this.successPanel.Visible = true;
      }
      else
      {
        this.successPanel.Visible = false;
        this.errorPanel.Visible = true;
      }
    }
  }
}
