using Microsoft.AspNet.Identity;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Reg
{
    public partial class intreruperi : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.Request.IsAuthenticated)
                this.Response.Redirect("../Account/Login.aspx");
            if ((this.Context.User.Identity.GetUserName() == "admin") || (this.Context.User.Identity.GetUserName() == "cristi"))
                return;
            this.Response.Redirect("../Account/Login.aspx");

        }

        protected void Calendar1_SelectionChanged(object sender, EventArgs e)
        {
            if ((Calendar2.SelectedDate - Calendar1.SelectedDate).TotalDays<0)
            {
                LiteralCalendaristice.Text = "...";
                LiteralLucratoare.Text = "...";
            }
            else
            {
                LiteralCalendaristice.Text = ((Calendar2.SelectedDate - Calendar1.SelectedDate).TotalDays+1).ToString();

                SqlConnection sqlConnection = new SqlConnection();
                sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
                SqlCommand sqlCommand = new SqlCommand();
                sqlCommand.Connection = sqlConnection;
                sqlCommand.CommandText = "ZileLucr";
                sqlCommand.CommandType = CommandType.StoredProcedure;
                
                sqlCommand.Parameters.Add(
                    new SqlParameter("@datai", Calendar1.SelectedDate.ToString("yyyy-MM-dd")
                    ));
                sqlCommand.Parameters.Add(
                    new SqlParameter("@datas", Calendar2.SelectedDate.ToString("yyyy-MM-dd")
                    ));

                sqlCommand.Connection.Open();
                //int zluc=
                    LiteralLucratoare.Text = (sqlCommand.ExecuteScalar()??0).ToString();
                sqlCommand.Connection.Close();

               /* LiteralLucratoare.Text = zluc.ToString()*/;



            }






        }

        protected void AddIntrerup_Command(object sender, CommandEventArgs e)
        {
            //INSERT INTO [INTRERUPERI] (MARCA,IdINTRERUP,DATAINCEPUT,DATASFARSIT)
            //VALUES(2003, -1, '2017-01-26', '2017-01-31')


            SqlConnection sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandText = " INSERT INTO [INTRERUPERI] (MARCA,IdINTRERUP,DATAINCEPUT,DATASFARSIT)  VALUES(" + this.DropDownListAngajat.SelectedValue.ToString() +","+ this.DropDownList1.SelectedValue.ToString()+",'"
                +Calendar1.SelectedDate.Year.ToString()+"-"+
                Calendar1.SelectedDate.Month.ToString() + "-" +
                Calendar1.SelectedDate.Day.ToString() +"','" 
                + Calendar2.SelectedDate.Year.ToString()+"-"
                + Calendar2.SelectedDate.Month.ToString() + "-"
                + Calendar2.SelectedDate.Day.ToString() + "')" ;
            sqlCommand.Connection.Open();
            try
            {
                sqlCommand.ExecuteNonQuery();
                this.Literal1.Text = "<strong>Adaugat cu success </strong>";
                GridView1.DataBind();
              
            }
            catch (SqlException ex)
            {
                this.Literal1.Text = ex.Message + "<br /> <strong>Eroare le addaugare </strong>";
            }
            sqlCommand.Connection.Close();
        }

        protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {

        }
    }
    
}