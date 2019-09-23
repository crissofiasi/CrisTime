using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace CrisTime.Reg
{
    public partial class WebForm1 : System.Web.UI.Page
    {
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
                this.Literal1.Text = "<br /> <strong>success CALCULARE </strong>";
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
            using (System.IO.StringWriter stringWriter = new StringWriter())
            {
                HtmlTextWriter htmlTextWriter = new HtmlTextWriter((TextWriter)stringWriter);
                Page page = new Page();
                HtmlForm htmlForm = new HtmlForm();
                page.Controls.Add((Control)htmlForm);
                htmlForm.Controls.Add((Control)this.Panel1);
                HttpContext.Current.Server.Execute((IHttpHandler)page, (TextWriter)stringWriter, true);
                string s = "<html xmlns: v = 'urn:schemas-microsoft-com:vml'\r\nxmlns: o = 'urn:schemas-microsoft-com:office:office'\r\nxmlns: x = 'urn:schemas-microsoft-com:office:excel'\r\nxmlns = 'http://www.w3.org/TR/REC-html40'>\r\n<body>\r\n<BR />\r\n";
                string str = Regex.Replace(Regex.Replace(stringWriter.ToString(), "</?(a|A).*?>", ""), "((<input.*?value=\")|(<input.*?text.{2}(?!value).*>)|(\" id=.*class=\"tt\".*?>)|(\" id=\"GridViewPontaj_TextBox_.*>))", "");
                str = Regex.Replace(str.ToString(), @"<div.*?abs.*?>(.|\n)*?/div>" , "");
                str = Regex.Replace(str.ToString(), @"<div.*?aspNetHidden.*?>(.|\n)*?/div>" , "");

                //style="font-size:X-Small;

                this.Response.Write(s);
                this.Response.Output.Write(str);
                this.Response.Write("</body></html>");
                this.Response.Flush();
                this.Response.End();
            }
        }



        protected void Button1_Click(object sender, EventArgs e)
        {
            //Literal1.Text = "-->";
            //foreach (GridViewRow row in GridView1.Rows)
            //{
            //    if(row.RowType == DataControlRowType.DataRow)
            //    {
            //        Literal1.Text = Literal1.Text + "  " + ((TextBox)row.Cells[3].FindControl("TextBox1")).Text.ToString();
            //        GridView1.DataBind();
            //    }
            //} 
        }

        protected void GridViewPontaj_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            LiteralFirma.Text = DropDownfirma.SelectedItem.Text.ToString();
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // scriu intreruperi

                for (int i = 4; i <= 34; i++)
                {
                    string name = "TextBox" + (i - 3).ToString().Trim();
                    string vv = ((TextBox)e.Row.Cells[i].FindControl(name)).Text.ToString().Trim();
                    ((TextBox)e.Row.Cells[i].FindControl(name)).ToolTip = ((TextBox)e.Row.Cells[i].FindControl(name)).Text.ToString().Trim();
                    if (vv.Length > 0)
                    {

                        int vvint = 0;
                        try
                        {
                            vvint = Convert.ToInt16(vv);
                        }
                        catch
                        {
                            vvint = 0;
                        }
                       
                        if (vvint<=0)
                        switch (vvint)
                        {
                            case -1:
                                ((TextBox)e.Row.Cells[i].FindControl(name)).Text = "CO";
                                break;
                            case -2:
                                ((TextBox)e.Row.Cells[i].FindControl(name)).Text = "CFS";
                                break;
                            case -3:
                                ((TextBox)e.Row.Cells[i].FindControl(name)).Text = "CM";
                                break;
                            case -4:
                                ((TextBox)e.Row.Cells[i].FindControl(name)).Text = "EV";
                                break;
                            case -5:
                                ((TextBox)e.Row.Cells[i].FindControl(name)).Text = "N";
                                break;
                                default : 
                                    {
                                        ((TextBox)e.Row.Cells[i].FindControl(name)).Text = " ";
                                        break;
                                    }
                               
                        }
                    }
                }



                // calculez totaluri
                int total = 0;
                for (int i = 4; i <= 34; i++)
                {
                    string name = "TextBox" + (i - 3).ToString().Trim();
                    string vv = ((TextBox)e.Row.Cells[i].FindControl(name)).Text.ToString().Trim();
                    ((TextBox)e.Row.Cells[i].FindControl(name)).ToolTip = ((TextBox)e.Row.Cells[i].FindControl(name)).Text.ToString().Trim();
                    if (vv.Length > 0)
                    {

                        int vvint = 0;
                        try
                        {
                            vvint= Convert.ToInt16(vv);
                        }
                        catch
                        {
                            vvint = 0;
                        }
                        total = total + vvint; 
                    }
                }
                e.Row.Cells[35].Text = total.ToString();

                //colorez sarbatori
                int luna = Convert.ToInt16(e.Row.Cells[2].Text);
                int an = Convert.ToInt16(e.Row.Cells[3].Text);
                for (int i = 4; i <= 34; i++)
                {
                    int zi = i - 3;
                    int tip = 0;
                    try
                    {
                        DateTime data = new DateTime(an, luna, zi);
                        if ((data.DayOfWeek.ToString() == "Sunday") || (data.DayOfWeek.ToString() == "Saturday"))
                            tip = 1;

                        int d2 = (Convert.ToInt16(data.Year) * 100 + Convert.ToInt16(data.Month)) * 100 + Convert.ToInt16(data.Day);
                        if (holyday.FindIndex(x => x == d2) > -1)
                        {
                            tip = 1;
                        }

                    }
                    catch
                    {
                        tip = -1;
                    }

                    if (tip < 0)
                    {
                        string name = "TextBox" + (i - 3).ToString().Trim();
                        ((TextBox)e.Row.Cells[i].FindControl(name)).BackColor = Color.Gray;
                        e.Row.Cells[i].BackColor = Color.Gray;
                        ((TextBox)e.Row.Cells[i].FindControl(name)).Enabled = false;
                    }
                    else if (tip > 0)
                    {
                        string name = "TextBox" + (i - 3).ToString().Trim();
                        ((TextBox)e.Row.Cells[i].FindControl(name)).BackColor = Color.SandyBrown;
                         e.Row.Cells[i].BackColor = Color.SandyBrown;

                    }

                    //completez jurnal scanari



                    SqlConnection sqlConnection = new SqlConnection();
                    sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
                    SqlCommand sqlCommand = new SqlCommand();
                    sqlCommand.Connection = sqlConnection;
                    //                    sqlCommand.CommandText = @"select  convert(varchar, [DATAORA], 104) AS DATA, convert(varchar(5), [DATAORA], 108) AS ORA,IIF([TIP]=0,'VENIRE','PLECARE') AS TIP FROM [ATTLOG] 
                    //WHERE MARCA = " + e.Row.Cells[0].Text.ToString().Trim() +
                    //@"AND TIP IN(0, 1)
                    //AND DATEPART(MONTH, DATAORA)=" + e.Row.Cells[2].Text.ToString().Trim() +
                    //"AND DATEPART(YEAR, DATAORA) =" + e.Row.Cells[3].Text.ToString().Trim() +
                    //"AND DATEPART(DAY, DATAORA) =" + (i - 3).ToString().Trim();

                    sqlCommand.CommandText = "GetLog";
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.Parameters.AddWithValue("@marca", e.Row.Cells[0].Text.ToString().Trim());
                    sqlCommand.Parameters.AddWithValue("@zi", (i - 3).ToString().Trim());
                    sqlCommand.Parameters.AddWithValue("@luna", e.Row.Cells[2].Text.ToString().Trim());
                    sqlCommand.Parameters.AddWithValue("@an", e.Row.Cells[3].Text.ToString().Trim());




                    sqlCommand.Connection.Open();
                    SqlDataReader reader= sqlCommand.ExecuteReader();
                    while (reader.Read())
                    {
                        Console.WriteLine(String.Format("{0}", reader[0]));
                        
                        string tabname = "TableJurnal" + (i - 3).ToString().Trim();
                        Table tab = ((Table)e.Row.FindControl(tabname));
                        TableRow tempRow = new TableRow();
                        TableCell tempCell = new TableCell();
                        tempCell.Text = e.Row.Cells[1].Text.ToString().Trim();
                        tempRow.Cells.Add(tempCell);

                        for (int cellNum = 0; cellNum < 3; cellNum++)
                        {
                            tempCell = new TableCell();
                            tempCell.Text = reader[cellNum].ToString();
                            tempRow.Cells.Add(tempCell);
                        }

                        try
                        {
                            tab.Rows.Add(tempRow);
                        }
                        catch
                        { }


                        
                        if((string)reader[2]=="VENIRE")
                        {
                            //completez venire

                            string Vname = "TextBox_v"+(i - 3).ToString().Trim();
                            ((TextBox)e.Row.Cells[i].FindControl(Vname)).Text = reader[1].ToString();



                        }

                        if ((string)reader[2] == "PLECARE")
                        {
                            //completez PLECARE

                            string Pname = "TextBox_p" + (i - 3).ToString().Trim();
                            ((TextBox)e.Row.Cells[i].FindControl(Pname)).Text = reader[1].ToString();


                        }

                    }


                    sqlCommand.Connection.Close();


                    // completez veniri
                    


                }








            }
            else if (e.Row.RowType == DataControlRowType.Header)
            {

            }


        }

        protected void Button1_Click1(object sender, EventArgs e)
        {




            Literal1.Text = "{ <br />";
            foreach (GridViewRow row in GridViewPontaj.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {

                    SqlConnection sqlConnection = new SqlConnection();
                    sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
                    SqlCommand sqlCommand = new SqlCommand();
                    sqlCommand.Connection = sqlConnection;
                    sqlCommand.CommandType = CommandType.StoredProcedure;
                    sqlCommand.CommandText = "[dbo].[CorectezPontaj]";
                    sqlCommand.Parameters.Add(new SqlParameter("@marca", row.Cells[0].Text));
                    sqlCommand.Parameters.Add(new SqlParameter("@an", row.Cells[3].Text));
                    sqlCommand.Parameters.Add(new SqlParameter("@luna", row.Cells[2].Text));

                    Literal1.Text = Literal1.Text + "-->" + row.Cells[0].Text + " " + row.Cells[1].Text + " " + row.Cells[2].Text + " " + row.Cells[3].Text + " ";
                    for (int z = 1; z <= 31; z++)
                    {
                        string textore = ((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).Text.ToString();
                        int ore;
                        if (textore.Trim().Length > 0)
                        {
                            ore = Convert.ToInt16(textore.ToString());
                            if (((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).Text.ToString() != ((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).ToolTip.ToString())
                            {
                                sqlCommand.Parameters.Add(new SqlParameter("@z" + z, ore.ToString()));
                            }

                            Literal1.Text = Literal1.Text + ore.ToString() + " ";
                        }
                        else
                        {
                            ore = -10;
                            Literal1.Text = Literal1.Text + " " + " ";
                        }


                    }
                    sqlCommand.Connection.Open();
                    sqlCommand.ExecuteNonQuery();
                    sqlCommand.Connection.Close();

                    Literal1.Text = Literal1.Text + "  <br />";
                    GridViewPontaj.DataBind();
                }
            }
            Literal1.Text = Literal1.Text + "<br /> }";


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

        protected void Button2_Command(object sender, CommandEventArgs e)
        {

            int an = 0, luna = 0, first = 0;

            DataTable zile;
            DataColumn tcolumn;
            DataRow trow;
            init_zile(out zile, out tcolumn);


            foreach (GridViewRow row in GridViewPontaj.Rows)
            {
                if (row.RowType == DataControlRowType.DataRow)
                {

                    if (an != Convert.ToInt32(row.Cells[3].Text) || luna != Convert.ToInt32(row.Cells[2].Text))
                    {
                        if (first == 0)
                            first = 1;
                        else
                        {
                            //insert into sql server

                            insSqlZile(an, luna, zile);

                        }
                        init_zile(out zile, out tcolumn);
                        luna = Convert.ToInt32(row.Cells[2].Text);
                        an = Convert.ToInt32(row.Cells[3].Text);
                    }
                    for (int z = 1; z <= 31; z++)
                    {
                        string textore = ((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).Text.ToString();
                        int ore;
                        if (textore.Trim().Length > 0)
                        {
                            try
                            {
                                ore = Convert.ToInt16(textore.ToString());
                            }
                            catch
                            {
                                switch (textore.ToUpper().Trim())
                                {
                                    case "CO":
                                        ore = -1;
                                        break;
                                    case "CFS":
                                        ore = -2;
                                        break;
                                    case "CM":
                                        ore = -3;
                                        break;
                                    case "EV":
                                        ore = -4;
                                        break;
                                    case "N":
                                        ore = -5;
                                        break;
                                    default:
                                        textore = ((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).ToolTip.ToString();
                                        ((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).Text = textore;
                                        ore = Convert.ToInt16(textore.ToString());
                                        ore = 0;
                                        break; 
                                  }

                            }
                            if (((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).Text.ToString() != ((TextBox)row.FindControl("TextBox" + z.ToString().Trim())).ToolTip.ToString())
                            {

                                trow = zile.NewRow();
                                trow["marca"] = Convert.ToInt32(row.Cells[0].Text);
                                trow["zi"] = z;
                                trow["val"] = ore;
                                zile.Rows.Add(trow);

                                //sqlCommand.Parameters.Add(new SqlParameter("@z" + z, ore.ToString()));
                            }

                      }
                        else
                        { ore = -10; }
                    }

                }
            }
            insSqlZile(an, luna, zile);
            Literal1.Text = "salvat";
            GridViewPontaj.DataBind();

            ButtonCalc_Click(sender, e);
        }

        private static void insSqlZile(int an, int luna, DataTable zile)
        {
            SqlConnection sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandType = CommandType.StoredProcedure;
            sqlCommand.CommandText = "[dbo].[CorectezPontaj2]";
            sqlCommand.Parameters.Add(new SqlParameter("@an", an));
            sqlCommand.Parameters.Add(new SqlParameter("@luna", luna));
            sqlCommand.Parameters.Add(new SqlParameter("@TabZile", zile));
            sqlCommand.Connection.Open();
            sqlCommand.ExecuteNonQuery();
            sqlCommand.Connection.Close();
        }

        private static void init_zile(out DataTable zile, out DataColumn tcolumn)
        {
            zile = new DataTable();
            tcolumn = new DataColumn();
            tcolumn.DataType = System.Type.GetType("System.Int32");
            tcolumn.ColumnName = "marca";
            zile.Columns.Add(tcolumn);
            tcolumn = new DataColumn();
            tcolumn.DataType = System.Type.GetType("System.Int32");
            tcolumn.ColumnName = "zi";
            zile.Columns.Add(tcolumn);
            tcolumn = new DataColumn();
            tcolumn.DataType = System.Type.GetType("System.Int32");
            tcolumn.ColumnName = "val";
            zile.Columns.Add(tcolumn);
        }

        protected void Button2_Click(object sender, EventArgs e)
        {

        }
    }
}