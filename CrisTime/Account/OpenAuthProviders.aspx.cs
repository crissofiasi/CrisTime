// Decompiled with JetBrains decompiler
// Type: CrisTime.Account.OpenAuthProviders
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using Microsoft.AspNet.Identity;
using Microsoft.Owin.Security;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Account
{
  public class OpenAuthProviders : UserControl
  {
    protected ListView providerDetails;

    public string ReturnUrl { get; set; }

    protected void Page_Load(object sender, EventArgs e)
    {
      if (!this.IsPostBack)
        return;
      string str1 = this.Request.Form["provider"];
      if (str1 == null)
        return;
      string str2 = this.ResolveUrl(string.Format((IFormatProvider) CultureInfo.InvariantCulture, "~/Account/RegisterExternalLogin?{0}={1}&returnUrl={2}", (object) "providerName", (object) str1, (object) this.ReturnUrl));
      AuthenticationProperties properties = new AuthenticationProperties()
      {
        RedirectUri = str2
      };
      if (this.Context.User.Identity.IsAuthenticated)
        properties.Dictionary["XsrfId"] = this.Context.User.Identity.GetUserId();
      this.Context.GetOwinContext().Authentication.Challenge(properties, str1);
      this.Response.StatusCode = 401;
      this.Response.End();
    }

    public IEnumerable<string> GetProviderNames()
    {
      return this.Context.GetOwinContext().Authentication.GetExternalAuthenticationTypes().Select<AuthenticationDescription, string>((Func<AuthenticationDescription, string>) (t => t.AuthenticationType));
    }
  }
}
