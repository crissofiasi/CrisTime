// Decompiled with JetBrains decompiler
// Type: CrisTime.Reg.condica
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;


namespace CrisTime.Reg
{
    public class condica : Page
    {
        private int ort;
        protected SqlDataSource SqlDataSourceCondica;
        protected SqlDataSource SqlDataSourceAN;
        protected SqlDataSource SqlDataSourceLuna;
        protected SqlDataSource SqlDataSourceZi;
        protected SqlDataSource SqlDataSourceNume;
        protected SqlDataSource SqlDataSource1;
        protected SqlDataSource SqlLogFormatii;
        protected Literal Literal1;
        protected Literal Literal2;
        protected Literal LitMsg;
        protected Button ButtonRefresh;
        protected DropDownList DropDownListZi;
        protected DropDownList DropDownListLuna;
        protected DropDownList DropDownListan;
        protected DropDownList DropDownListMarca;
        protected Panel Panel1;
        protected GridView GridView1;
        protected Button Expexcel;
        protected Literal LiteralAngajat;
        protected GridView GridView3;
        protected Literal LiteralScanari;
        protected GridView GridView2;
        protected Calendar Calendar1;

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
                Calendar1.SelectedDate = DateTime.Today.AddDays(-1.0);
                Calendar1.VisibleDate = Calendar1.SelectedDate;



                DropDownList dropDownListZi = this.DropDownListZi;
                DateTime dateTime1 = DateTime.Now;
                dateTime1 = dateTime1.AddDays(-1.0);
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

        protected void BtnAfiseaza_Click(object sender, EventArgs e)
        {
        }

        protected void ButtonRefresh_Click(object sender, EventArgs e)
        {
            this.GridView1.DataBind();
        }

        protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Cells[6].Text = DataBinder.Eval(e.Row.DataItem, "VENIRE").ToString().Substring(0, 2).ToString() + ":" + DataBinder.Eval(e.Row.DataItem, "VENIRE").ToString().Substring(2, 2).ToString();
                e.Row.Cells[7].Text = DataBinder.Eval(e.Row.DataItem, "PLECARE").ToString().Substring(0, 2).ToString() + ":" + DataBinder.Eval(e.Row.DataItem, "PLECARE").ToString().Substring(2, 2).ToString();

                if (DataBinder.Eval(e.Row.DataItem, "REDUCERI").ToString().Length > 0)
                {
                    e.Row.Cells[8].Style["text-decoration"] = "line-through";
                    //e.Row.Cells[8].Text = "&nbsp" + DataBinder.Eval(e.Row.DataItem, "ORE").ToString().Split('.').First<string>().ToString() + "&nbsp";
                    e.Row.Cells[8].Text = "&nbsp" + e.Row.Cells[8].Text.Trim() + "&nbsp";
                    try
                    {
                        int k = Convert.ToInt16(e.Row.Cells[9].Text.Trim());
                        if (k<0)
                        {
                            switch (k)
                            {
                                case -1:
                                    e.Row.Cells[9].Text = "CO";
                                    break;
                                case -2:
                                    e.Row.Cells[9].Text = "CFS";
                                    break;
                                case -3:
                                    e.Row.Cells[9].Text = "CM";
                                    break;
                                case -4:
                                    e.Row.Cells[9].Text = "EV";
                                    break;
                                case -5:
                                    e.Row.Cells[9].Text = "N";
                                    break;
                                default:
                                    //e.Row.Cells[9].Text = "";
                                    break;
                            }
                        }
                    }
                    catch
                    { }


                }
            }

            if (e.Row.RowType != DataControlRowType.DataRow || !(DataBinder.Eval(e.Row.DataItem, "VENIRE").ToString() == "0000") && !(DataBinder.Eval(e.Row.DataItem, "PLECARE").ToString() == "0000"))
                return;
            e.Row.BackColor = Color.Yellow;
            e.Row.ForeColor = Color.Red;
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
                string s = "<html xmlns: v = 'urn:schemas-microsoft-com:vml'\r\nxmlns: o = 'urn:schemas-microsoft-com:office:office'\r\nxmlns: x = 'urn:schemas-microsoft-com:office:excel'\r\nxmlns = 'http://www.w3.org/TR/REC-html40'>\r\n<body>\r\n<p>\r\ntitlu raport\r\n</P>\r\n<BR />\r\n<BR />\r\n<BR />\r\n<BR />\r\n";
                string str = Regex.Replace(Regex.Replace(stringWriter.ToString(), "</?(a|A).*?>", ""), "</?(input|INPUT).*?>", "");
                this.Response.Write(s);
                this.Response.Output.Write(str);
                this.Response.Write("</body></html>");
                this.Response.Flush();
                this.Response.End();
            }
        }

        protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
        }

        protected void GridView3_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            e.NewValues[(object)"fid"] = e.Keys[(object)"fid"];
            e.NewValues[(object)"marca"] = e.Keys[(object)"marca"];
            e.NewValues[(object)"zi"] = e.Keys[(object)"zi"];
            e.NewValues[(object)"luna"] = e.Keys[(object)"luna"];
            e.NewValues[(object)"an"] = e.Keys[(object)"an"];
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            this.LiteralAngajat.Text = "Repartizare program de lucru <br />" + this.GridView1.SelectedDataKey["NUME"].ToString() + "<br />" + this.GridView1.SelectedDataKey["zi"].ToString() + "/" + this.GridView1.SelectedDataKey["luna"].ToString() + "/" + this.GridView1.SelectedDataKey["an"].ToString();
        }

        protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.Header)
            {
                this.ort = 0;
                this.LiteralAngajat.Text = "Repartizare program de lucru <br />" + this.GridView1.SelectedDataKey["NUME"].ToString() + "<br />" + this.GridView1.SelectedDataKey["zi"].ToString() + "/" + this.GridView1.SelectedDataKey["luna"].ToString() + "/" + this.GridView1.SelectedDataKey["an"].ToString();
            }
            else if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (DataBinder.Eval(e.Row.DataItem, "timp").ToString().Trim().Length <= 0)
                    return;
                this.ort = this.ort + (int)Convert.ToInt16(DataBinder.Eval(e.Row.DataItem, "timp").ToString());
            }
            else
            {
                if (e.Row.RowType != DataControlRowType.Footer)
                    return;
                e.Row.Cells[1].Text = "Total Ore <BR /> Reparitzate";
                e.Row.Cells[4].Text = this.ort.ToString();
                int result = 0;
                int.TryParse(((IEnumerable<string>)this.GridView1.SelectedDataKey["ORE"].ToString().Split('.')).First<string>(), out result);
                int RESMAN = result;
                int.TryParse(((IEnumerable<string>)RESMAN.ToString().Split(',')).First<string>(), out result);

                //  result = Convert.ToInt16(this.GridView1.SelectedDataKey["ORE"].ToString());
                int num = result - this.ort;
                if (num > 0)
                {
                    e.Row.Cells[5].Text = "   Ramas de repartizat  =   " + num.ToString() + " ore ";
                    e.Row.BorderColor = Color.OrangeRed;
                    e.Row.BorderWidth = (Unit)3;
                }
                else
                {
                    if (num >= 0)
                        return;
                    e.Row.Cells[5].Text = " Erroare:  sa repartizat mai mult    ( " + (-1 * num).ToString() + " ore )";
                    e.Row.BackColor = Color.OrangeRed;
                    e.Row.ForeColor = Color.Yellow;
                }
            }
        }

        protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType != DataControlRowType.Header)
                return;
            this.LiteralScanari.Text = " <center> Jurnal scanari <br />" + this.GridView1.SelectedDataKey["NUME"].ToString() + "</center>";
        }

        protected void GridView1_DataBound(object sender, EventArgs e)
        {
            if ((Context.User.Identity.GetUserName().ToString() == "director") || ((Context.User.Identity.GetUserName().ToString() == "cristi")))
            {
                GridView1.Columns[10].Visible = true;

            }
        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            DropDownListZi.SelectedValue = Calendar1.SelectedDate.Day.ToString().PadLeft(2);
            DropDownListLuna.SelectedValue = Calendar1.SelectedDate.Month.ToString().Trim().PadLeft(2);
            DropDownListan.SelectedValue = Calendar1.SelectedDate.Year.ToString().Trim().PadLeft(4);


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

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime dd = e.Day.Date;
            int d2 = (Convert.ToInt16(dd.Year) * 100 + Convert.ToInt16(dd.Month)) * 100 + Convert.ToInt16(dd.Day);
            if (holyday.FindIndex(x => x == d2) > -1)
            {
               e.Cell.BackColor = System.Drawing.ColorTranslator.FromHtml("#FFAA88");
                e.Cell.ForeColor = System.Drawing.ColorTranslator.FromHtml("#FF0000");
                
            }
        }

        protected void btnImportRecords_Click(object sender, EventArgs e)
        {
            CrisTime.clases.DeviceUtils utils = new CrisTime.clases.DeviceUtils();
            utils.ImportRecordsFromDevice();
            LitMsg.Text = utils.msg;
            this.GridView1.DataBind();
        }
    }
}
