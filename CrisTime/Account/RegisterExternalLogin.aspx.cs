// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.RegisterExternalLogin
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
  public class RegisterExternalLogin : Page
  {
    protected TextBox email;

    protected string ProviderName
    {
      get
      {
        return (string) this.ViewState["ProviderName"] ?? string.Empty;
      }
      private set
      {
        this.ViewState["ProviderName"] = (object) value;
      }
    }

    protected string ProviderAccountKey
    {
      get
      {
        return (string) this.ViewState["ProviderAccountKey"] ?? string.Empty;
      }
      private set
      {
        this.ViewState["ProviderAccountKey"] = (object) value;
      }
    }

    private void RedirectOnFail()
    {
      this.Response.Redirect(this.User.Identity.IsAuthenticated ? "~/Account/Manage" : "~/Account/Login");
    }

    protected void Page_Load()
    {
      this.ProviderName = IdentityHelper.GetProviderNameFromRequest(this.Request);
      if (string.IsNullOrEmpty(this.ProviderName))
      {
        this.RedirectOnFail();
      }
      else
      {
        if (this.IsPostBack)
          return;
        ApplicationUserManager userManager = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
        ApplicationSignInManager manager = this.Context.GetOwinContext().Get<ApplicationSignInManager>();
        ExternalLoginInfo externalLoginInfo1 = this.Context.GetOwinContext().Authentication.GetExternalLoginInfo();
        if (externalLoginInfo1 == null)
        {
          this.RedirectOnFail();
        }
        else
        {
          ApplicationUser user = userManager.Find<ApplicationUser, string>(externalLoginInfo1.Login);
          if (user != null)
          {
            manager.SignIn<ApplicationUser, string>(user, false, false);
            IdentityHelper.RedirectToReturnUrl(this.Request.QueryString["ReturnUrl"], this.Response);
          }
          else if (this.User.Identity.IsAuthenticated)
          {
            ExternalLoginInfo externalLoginInfo2 = this.Context.GetOwinContext().Authentication.GetExternalLoginInfo("XsrfId", this.User.Identity.GetUserId());
            if (externalLoginInfo2 == null)
            {
              this.RedirectOnFail();
            }
            else
            {
              IdentityResult result = userManager.AddLogin<ApplicationUser, string>(this.User.Identity.GetUserId(), externalLoginInfo2.Login);
              if (result.Succeeded)
                IdentityHelper.RedirectToReturnUrl(this.Request.QueryString["ReturnUrl"], this.Response);
              else
                this.AddErrors(result);
            }
          }
          else
            this.email.Text = externalLoginInfo1.Email;
        }
      }
    }

    protected void LogIn_Click(object sender, EventArgs e)
    {
      this.CreateAndLoginUser();
    }

    private void CreateAndLoginUser()
    {
      if (!this.IsValid)
        return;
      ApplicationUserManager userManager1 = this.Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
      ApplicationSignInManager userManager2 = this.Context.GetOwinContext().GetUserManager<ApplicationSignInManager>();
      ApplicationUser applicationUser = new ApplicationUser();
      string text1 = this.email.Text;
      applicationUser.UserName = text1;
      string text2 = this.email.Text;
      applicationUser.Email = text2;
      ApplicationUser user = applicationUser;
      IdentityResult result = userManager1.Create<ApplicationUser, string>(user);
      if (result.Succeeded)
      {
        ExternalLoginInfo externalLoginInfo = this.Context.GetOwinContext().Authentication.GetExternalLoginInfo();
        if (externalLoginInfo == null)
        {
          this.RedirectOnFail();
          return;
        }
        result = userManager1.AddLogin<ApplicationUser, string>(user.Id, externalLoginInfo.Login);
        if (result.Succeeded)
        {
          userManager2.SignIn<ApplicationUser, string>(user, false, false);
          IdentityHelper.RedirectToReturnUrl(this.Request.QueryString["ReturnUrl"], this.Response);
          return;
        }
      }
      this.AddErrors(result);
    }

    private void AddErrors(IdentityResult result)
    {
      foreach (string error in result.Errors)
        this.ModelState.AddModelError("", error);
    }
  }
}
