// Decompiled with JetBrains decompiler
// Type: CrisTime.Reg.ATTLOG
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Reg
{
    public class ATTLOG : Page
    {
        protected SqlDataSource SqlDataSource1;
        protected SqlDataSource SqlDataSourceAN;
        protected SqlDataSource SqlDataSourceLuna;
        protected SqlDataSource SqlDataSourceZi;
        protected SqlDataSource SqlDataSourceNume;
        protected DropDownList DropDownListZi;
        protected DropDownList DropDownListLuna;
        protected DropDownList DropDownListan;
        protected DropDownList DropDownListMarca;
        protected GridView GridView1;
        protected Calendar Calendar1;

        protected void Page_Load(object sender, EventArgs e)
        {

            if(!this.Request.IsAuthenticated)
        this.Response.Redirect("../Account/Login.aspx");
            if (this.IsPostBack)
                return;
            try
            {
                Calendar1.SelectedDate = DateTime.Today;
                Calendar1.VisibleDate = Calendar1.SelectedDate;

                DropDownList dropDownListZi = this.DropDownListZi;
                DateTime dateTime1 = DateTime.Now;
             //   dateTime1 = dateTime1.AddDays(-1.0);
                int num = dateTime1.Day;
                string str1 = num.ToString().PadLeft(2);
                dropDownListZi.SelectedValue = str1;
                DropDownList dropDownListLuna = this.DropDownListLuna;
                DateTime dateTime2 = DateTime.Now;
                dateTime2 = dateTime2.AddDays(-1.0);
                num = dateTime2.Month;
                string str2 = num.ToString().Trim().PadLeft(2);
                dropDownListLuna.SelectedValue = str2;
                DropDownList dropDownListan = this.DropDownListan;
                num = DateTime.Now.AddDays(-1.0).Year;
                string str3 = num.ToString().Trim().PadLeft(4);
                dropDownListan.SelectedValue = str3;
                
            }
            catch
            {
            }

        }
        protected void DATE_SelectedIndexChanged(object sender, EventArgs e)
        {
            if ((DropDownListZi.SelectedValue.ToString().Trim() != "zi") && (DropDownListLuna.SelectedValue.ToString().Trim() != "luna") && (DropDownListan.SelectedValue.ToString().Trim() != "an"))
            {
                DateTime data;
                data = new DateTime(Convert.ToInt16(DropDownListan.SelectedValue.ToString().Trim()), Convert.ToInt16(DropDownListLuna.SelectedValue.ToString().Trim()), Convert.ToInt16(DropDownListZi.SelectedValue.ToString().Trim()));
                Calendar1.SelectedDate = data;
                Calendar1.VisibleDate = data;
            }
            else
            {
                Calendar1.SelectedDate = new DateTime();
                Calendar1.VisibleDate = DateTime.Now;
            }
        }
        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            DropDownListZi.SelectedValue = Calendar1.SelectedDate.Day.ToString().Trim().PadLeft(2);
            DropDownListLuna.SelectedValue = Calendar1.SelectedDate.Month.ToString().Trim().PadLeft(2);
            DropDownListan.SelectedValue = Calendar1.SelectedDate.Year.ToString().Trim().PadLeft(4);


        }



    }
}
