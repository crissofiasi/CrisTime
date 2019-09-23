using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace CrisTime.Reg
{
    public partial class sarbatori : System.Web.UI.Page
    {
        public List<int> holyday;
        protected void Page_Load(object sender, EventArgs e)
        {
            init_holydays();

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

        protected void Button_adauga_Command(object sender, CommandEventArgs e)
        {

            SqlConnection sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandText = " INSERT INTO [SARBATORI] (data,nume)  VALUES('" + 
                
                this.Calendar1.SelectedDate.Year.ToString().Trim()+"-"+
                this.Calendar1.SelectedDate.Month.ToString().Trim() + "-" +
                 this.Calendar1.SelectedDate.Day.ToString().Trim() 

                + "','" + this.TextBox_Denumire.Text.ToString() + "')";
            sqlCommand.Connection.Open();
            try
            {
                sqlCommand.ExecuteNonQuery();
                this.Literal1.Text = "<strong>Sarbatoare legala daugata cu success </strong>";
                GridView1.DataBind();

            }
            catch (SqlException ex)
            {
                this.Literal1.Text = ex.Message + "<br /> <strong>Eroare le addaugare </strong>";
            }
            sqlCommand.Connection.Close();



        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            GridView1.Rows[e.RowIndex].Cells[0].Visible = true;
            GridView1.SelectRow(e.RowIndex);
            string idd = GridView1.SelectedDataKey[0].ToString();
            Literal1.Text = ":" + idd;
            

            SqlConnection sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
            SqlCommand sqlCommand = new SqlCommand();
            sqlCommand.Connection = sqlConnection;
            sqlCommand.CommandText = " delete from [SARBATORI] where id=" + idd.Trim();
            sqlCommand.Connection.Open();
            try
            {
                sqlCommand.ExecuteNonQuery();
                this.Literal1.Text = "<strong>Sarbatoare legala stearsa cu success </strong>";
                GridView1.DataBind();

            }
            catch (SqlException ex)
            {
                this.Literal1.Text = this.Literal1.Text+"<br>/"+ ex.Message + "<br /> <strong>Eroare le stergere </strong>";
            }
            sqlCommand.Connection.Close();
            e.Cancel = true;

        }

        protected void Calendar1_DayRender(object sender, DayRenderEventArgs e)
        {
            DateTime dd = e.Day.Date;
            int d2 = (Convert.ToInt16(dd.Year) * 100 + Convert.ToInt16(dd.Month)) * 100 + Convert.ToInt16(dd.Day);
            if(holyday.FindIndex(x=>x==d2)>-1)
            {
                e.Cell.BackColor=System.Drawing.Color.Red;
            }
        }
    }
}