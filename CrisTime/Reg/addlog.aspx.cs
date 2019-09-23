// Decompiled with JetBrains decompiler
// Type: CrisTime.Reg.addlog
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Reg
{
  public class addlog : Page
  {
    protected Literal Literal1;
    protected DropDownList DropDownListAngajat;
    protected DropDownList DropDownListTip;
    protected SqlDataSource SqlDataSourceAng;
    protected TextBox TextBoxZi;
    protected TextBox TextBoxLuna;
    protected TextBox TextBoxAn;
    protected TextBox TextBoxOra;
    protected TextBox TextBoxMinut;
    protected Button ButtonAdd;
    protected global::System.Web.UI.WebControls.Calendar Calendar1;

        protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
      SqlConnection sqlConnection = new SqlConnection();
      sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
      SqlCommand sqlCommand = new SqlCommand();
      sqlCommand.Connection = sqlConnection;
      sqlCommand.CommandText = " INSERT INTO [ATTLOG] (MARCA, DATAORA, TIP)  VALUES(" + this.DropDownListAngajat.SelectedValue.ToString() + ", isnull((SELECT  DATETIMEFROMPARTS(" + this.TextBoxAn.Text.Trim() + "," + this.TextBoxLuna.Text.Trim() + "," + this.TextBoxZi.Text.Trim() + "," + this.TextBoxOra.Text.Trim() + "," + this.TextBoxMinut.Text.Trim() + ", 00, MAX(DATEPART(MILLISECOND,[DATAORA])) + 5) FROM[CrisTime].[dbo].[ATTLOG] where DATEPART(year,[DATAORA]) = " + this.TextBoxAn.Text.Trim() + " and DATEPART(month,[DATAORA]) = " + this.TextBoxLuna.Text.Trim() + " and DATEPART(day,[DATAORA]) = " + this.TextBoxZi.Text.Trim() + " and DATEPART(HOUR,[DATAORA]) = " + this.TextBoxOra.Text.Trim() + " and DATEPART(MINUTE,[DATAORA]) = " + this.TextBoxMinut.Text.Trim() + " ), DATETIMEFROMPARTS(" + this.TextBoxAn.Text.Trim() + ", " + this.TextBoxLuna.Text.Trim() + "," + this.TextBoxZi.Text.Trim() + "," + this.TextBoxOra.Text.Trim() + "," + this.TextBoxMinut.Text.Trim() + ", 00, 00) )," + this.DropDownListTip.SelectedValue.ToString().Trim() + ")";
      sqlCommand.Connection.Open();
      try
      {
        sqlCommand.ExecuteNonQuery();
        this.Literal1.Text = "<strong>Adaugat cu success </strong>";
      }
      catch (SqlException ex)
      {
        this.Literal1.Text = ex.Message + "<br /> <strong>Eroare le addaugare </strong>";
      }
      sqlCommand.Connection.Close();
    }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {

            TextBoxAn.Text = Calendar1.SelectedDate.Year.ToString();
            TextBoxLuna.Text = Calendar1.SelectedDate.Month.ToString();
            TextBoxZi.Text = Calendar1.SelectedDate.Day.ToString();
           
        }
    }
}
