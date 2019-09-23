// Decompiled with JetBrains decompiler
// Type: CrisTime.Reg.pontaj
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

using Microsoft.AspNet.Identity;
using System.Collections.Generic;
using System.Linq;



namespace CrisTime.Reg
{
    public class pontaj : Page
    {
        protected SqlDataSource SqlDataSourcepontaj;
        protected SqlDataSource SqlDataSourceAN;
        protected SqlDataSource SqlDataSourceLuna;
        protected SqlDataSource SqlDataSourceZi;
        protected SqlDataSource SqlDataSourceNume;
        protected SqlDataSource SqlDataSourcefirma;
        protected Literal Literal1;
        protected Button ButtonCalc;
        protected DropDownList DropDownListLuna;
        protected DropDownList DropDownListan;
        protected DropDownList DropDownListMarca;
        protected DropDownList DropDownfirma;
        protected Panel Panel1;
        protected Literal LiteralFirma;
        protected Literal LiteralLuna;
        protected Literal LiteralAn;
        protected GridView GridViewPontaj;
        protected Button Expexcel;
        public List<int> holyday;

        protected void Page_Load(object sender, EventArgs e)
        {
            init_holydays();
            if (!this.Request.IsAuthenticated)
                this.Response.Redirect("../Account/Login.aspx");
            if (this.IsPostBack)
                return;
            try
            {
                DropDownList dropDownListLuna = this.DropDownListLuna;
                DateTime dateTime = DateTime.Now;
                dateTime = dateTime.AddDays(-1.0);
                int num = dateTime.Month;
                string str1 = num.ToString().Trim();
                dropDownListLuna.SelectedValue = str1;
                DropDownList dropDownListan = this.DropDownListan;
                num = DateTime.Now.AddDays(-1.0).Year;
                string str2 = num.ToString().Trim();
                dropDownListan.SelectedValue = str2;
            }
            catch
            {
            }
        }

        protected void ButtonCalc_Click(object sender, EventArgs e)
        {
            SqlConnection sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "[dbo].[ActualizPontaj]";
            SqlParameter sqlParameter1 = new SqlParameter("@luna", (object)this.DropDownListLuna.SelectedValue);
            sqlParameter1.Direction = ParameterDirection.Input;
            sqlParameter1.DbType = DbType.Int16;
            sqlCommand.Parameters.Add(sqlParameter1);
            SqlParameter sqlParameter2 = new SqlParameter("@an", (object)this.DropDownListan.SelectedValue);
            sqlParameter2.Direction = ParameterDirection.Input;
            sqlParameter2.DbType = DbType.Int16;
            sqlCommand.Parameters.Add(sqlParameter2);
            sqlCommand.Connection.Open();
            try
            {
                sqlCommand.ExecuteNonQuery();
                this.Literal1.Text = "<br /> <strong>success </strong>";
            }
            catch (SqlException ex)
            {
                this.Literal1.Text = ex.Message + "<br /> <strong>error </strong>";
            }
            sqlCommand.Connection.Close();
            this.GridViewPontaj.DataBind();
        }

        protected void Expexcel_Click(object sender, EventArgs e)
        {
            this.Response.Clear();
            this.Response.Buffer = true;
            this.Response.AddHeader("content-disposition", "attachment;filename=GridViewExport.xls");
            this.Response.Charset = "";
            this.Response.ContentType = "application/vnd.ms-excel";
            using (StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter htmlTextWriter = new HtmlTextWriter((TextWriter)stringWriter);
                Page page = new Page();
                HtmlForm htmlForm = new HtmlForm();
                page.Controls.Add((Control)htmlForm);
                htmlForm.Controls.Add((Control)this.Panel1);
                HttpContext.Current.Server.Execute((IHttpHandler)page, (TextWriter)stringWriter, true);
                string s = "<html xmlns: v = 'urn:schemas-microsoft-com:vml'\r\nxmlns: o = 'urn:schemas-microsoft-com:office:office'\r\nxmlns: x = 'urn:schemas-microsoft-com:office:excel'\r\nxmlns = 'http://www.w3.org/TR/REC-html40'>\r\n<body>\r\n<BR />\r\n";
                string str = Regex.Replace(Regex.Replace(stringWriter.ToString(), "</?(a|A).*?>", ""), "</?(input|INPUT).*?>", "");
                this.Response.Write(s);
                this.Response.Output.Write(str);
                this.Response.Write("</body></html>");
                this.Response.Flush();
                this.Response.End();
            }
        }

        protected void GridViewPontaj_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            e.Row.Cells[0].BackColor = Color.Cornsilk;
            e.Row.Cells[1].BackColor = Color.Cornsilk;
            e.Row.Cells[2].BackColor = Color.Cornsilk;
            e.Row.Cells[3].BackColor = Color.Cornsilk;
            e.Row.Cells[35].BackColor = Color.LightBlue;
            try
            {
                int int32_1 = Convert.ToInt32(this.DropDownListLuna.Text);
                int int32_2 = Convert.ToInt32(this.DropDownListan.Text);
                e.Row.Cells[2].Visible = false;
                e.Row.Cells[3].Visible = false;
                this.LiteralAn.Text = int32_2.ToString();
                this.LiteralLuna.Text = new DateTime(2015, int32_1, 1).ToString("MMMM", (IFormatProvider)CultureInfo.CreateSpecificCulture("ro"));
                this.LiteralFirma.Text = this.DropDownfirma.SelectedItem.Text;
            }
            catch
            {
                this.LiteralLuna.Text = "";
                this.LiteralAn.Text = "";
            }
            if (e.Row.RowType == DataControlRowType.Header)
            {
                try
                {


                    int int32_1 = Convert.ToInt32(this.DropDownListLuna.Text);
                    int int32_2 = Convert.ToInt32(this.DropDownListan.Text);
                    for (int day = 1; day <= 31; ++day)
                    {
                        try
                        {
                            DateTime dateTime = new DateTime(int32_2, int32_1, day);
                            try
                            {
                                int d2 = (Convert.ToInt16(dateTime.Year) * 100 + Convert.ToInt16(dateTime.Month)) * 100 + Convert.ToInt16(dateTime.Day);
                                if (holyday.FindIndex(x => x == d2) > -1)
                                {
                                    e.Row.Cells[day + 3].BackColor = Color.SandyBrown;
                                }
                            }
                            catch
                            {

                            }

                            if (!(dateTime.DayOfWeek.ToString() == "Sunday"))
                            {
                                if (!(dateTime.DayOfWeek.ToString() == "Saturday"))
                                    continue;
                            }
                            e.Row.Cells[day + 3].BackColor = Color.SandyBrown;


                        }
                        catch
                        {
                            e.Row.Cells[day + 3].BackColor = Color.Gray;
                            e.Row.Cells[day + 3].Visible = false;
                        }
                    }
                }
                catch
                {
                }
            }
            if (e.Row.RowType != DataControlRowType.DataRow)
                return;
            int int32_3 = Convert.ToInt32(e.Row.Cells[2].Text);
            int int32_4 = Convert.ToInt32(e.Row.Cells[3].Text);
            int num = 0;
            for (int day = 1; day <= 31; ++day)
            {
                try
                {
                    DateTime dateTime = new DateTime(int32_4, int32_3, day);
                    try
                    {
                        int d2 = (Convert.ToInt16(dateTime.Year) * 100 + Convert.ToInt16(dateTime.Month)) * 100 + Convert.ToInt16(dateTime.Day);
                        if (holyday.FindIndex(x => x == d2) > -1)
                        {
                            e.Row.Cells[day + 3].BackColor = Color.SandyBrown;
                        }
                    }
                    catch
                    {

                    }

                    if (!(dateTime.DayOfWeek.ToString() == "Sunday"))
                    {
                        if (!(dateTime.DayOfWeek.ToString() == "Saturday"))
                            goto label_21;
                    }
                    e.Row.Cells[day + 3].BackColor = Color.SandyBrown;
                }
                catch
                {
                    e.Row.Cells[day + 3].BackColor = Color.Gray;
                    try
                    {
                        Convert.ToInt32(this.DropDownListLuna.Text);
                        Convert.ToInt32(this.DropDownListan.Text);
                        e.Row.Cells[day + 3].Visible = false;
                    }
                    catch
                    {
                    }
                }
                label_21:
                try
                {

                    int k = (int)Convert.ToInt16(e.Row.Cells[day + 3].Text);
                    if(k<0)
                    {
                        
                        switch (k)
                        {
                            case -1:
                                e.Row.Cells[day + 3].Text = "CO";
                                break;
                            case -2:
                                e.Row.Cells[day + 3].Text = "CFS";
                                break;
                            case -3:
                                e.Row.Cells[day + 3].Text = "CM";
                                break;
                            case -4:
                                e.Row.Cells[day + 3].Text = "EV";
                                break;
                            case -5:
                                e.Row.Cells[day + 3].Text = "N";
                                break;
                            default:
                                e.Row.Cells[day + 3].Text = "";
                                break;
                        }
                        k = 0;
                    }


                    num += k;



                }
                catch
                {
                }
            }
            e.Row.Cells[35].Text = num.ToString();
        }


        private void init_holydays()
        {
            SqlDataReader reader;
            SqlConnection sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandText = " select data from [SARBATORI]";
            sqlCommand.Connection.Open();

            try
            {
                reader = sqlCommand.ExecuteReader();
                holyday = new List<int>();
                while (reader.Read())
                {

                    holyday.Add((Convert.ToDateTime(reader["data"]).Year * 100 + Convert.ToDateTime(reader["data"]).Month) * 100 + Convert.ToDateTime(reader["data"]).Day);

                }

            }
            catch (SqlException ex)
            {
                this.Literal1.Text = ex.Message + "<br /> <strong>Eroare la interogare sarbatori </strong>";
            }
            sqlCommand.Connection.Close();
        }

    }
}
