// Decompiled with JetBrains decompiler
// Type: CrisTime.Reg.Angajati
// Assembly: CrisTime, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: E70DEA98-2EED-46FB-BE95-A1A3BD74C85E
// Assembly location: T:\cristime\bin\CrisTime.dll

using Microsoft.AspNet.Identity;
using System;
using System.Configuration;
using System.Data;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CrisTime.Reg
{
  public class Angajati : Page
  {
    protected Literal Literal1;
        protected Literal Literal2;


        protected Label LabelMarca;
        protected Label LabelNume;
        protected Label LabelData_ang;
        protected Label LabelCNP;
        protected Label LabelComp;
        protected TextBox TextMarca;
        protected TextBox TextNume;
        protected TextBox TextData_ang;
        protected TextBox TextCNP;
        protected TextBox TextCARD;
        //protected TextBox XlsFile;
        protected DropDownList DropDownListComp;
        protected Button ButtonAdd;
        protected Button ActualizareSalar;
        protected GridView GridView1;
        protected SqlDataSource SqlDataSource1;
        protected SqlDataSource SqlDataSourceComp;
        protected FileUpload FileUpload1;


    protected void Page_Load(object sender, EventArgs e)
    {
      if (!this.Request.IsAuthenticated)
        this.Response.Redirect("../Account/Login.aspx");
      if ((this.Context.User.Identity.GetUserName() == "admin") || (this.Context.User.Identity.GetUserName() == "cristi"))
        return;
      this.Response.Redirect("../Account/Login.aspx");
    }

    protected void ButtonAdd_Click(object sender, EventArgs e)
    {
      SqlConnection sqlConnection = new SqlConnection();
      sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
      SqlCommand sqlCommand = new SqlCommand();
      sqlCommand.Connection = sqlConnection;
      sqlCommand.CommandText = " INSERT INTO[USER] (MARCA, NUME, CNP, DATA_ANG, IdCOMPANIE,CARD)  VALUES (" + this.TextMarca.Text + ",'" + this.TextNume.Text + "'," + this.TextCNP.Text + ",'" + this.TextData_ang.Text + "'," + this.DropDownListComp.SelectedValue.ToString()+ ",'" + TrimCardNumber(Convert.ToInt64(this.TextCARD.Text.Trim())).ToString() + "')";
      sqlCommand.Connection.Open();
      try
      {
        sqlCommand.ExecuteNonQuery();
        this.GridView1.DataBind();
      }
      catch (SqlException ex)
      {
        this.Literal1.Text = ex.Message + "<br /> <strong>Angajatul exista deja </strong>";
      }
      sqlCommand.Connection.Close();
    }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            string marca = this.GridView1.SelectedDataKey["MARCA"].ToString();

            string nume = this.GridView1.SelectedRow.Cells[1].Text.ToString();

            string card = this.GridView1.SelectedRow.Cells[5].Text.ToString();

            zkemkeeper.CZKEM aa = new zkemkeeper.CZKEM();
            Literal2.Text = "";

            if (aa.Connect_Net("10.10.13.10", 4370))
            {
                Literal2.Text = Literal2.Text + " " + "Conectat...";
                //aa.SetStrCardNumber("");
                if (aa.SetStrCardNumber(card))
                {
                    Literal2.Text = Literal2.Text + " " + "actualizat card :" + card;
                }
                else
                {
                    Literal2.Text = Literal2.Text + " " + "EROARE actualizare card " + card;
                }
                if (aa.SSR_SetUserInfo(1, marca, nume, "", 0, true))
                {
                    
                    Literal2.Text = Literal2.Text + " " + "actualizat " + marca + " " + nume;
                }
                else
                {
                    Literal2.Text = Literal2.Text + " " + "EROARE actualizare " + marca + " " + nume;

                }
                aa.Disconnect();

            }
            else
            {
                Literal2.Text = "nu m-am putrut conecta la aparat";
            }


            }

        protected void ActualizareSalar_Click(object sender, EventArgs e)
        {
            string serverpath = "-";
            if (FileUpload1.HasFile)
            {
                try
                {
                    string filename = Path.GetFileName(FileUpload1.FileName);
                    serverpath = Server.MapPath("~/") + "aaa.xlsx";
                    FileUpload1.SaveAs(serverpath);
                    Literal1.Text = "Upload status: File uploaded!";
                   // XlsFile.Text = serverpath;
                }
                catch (Exception ex)
                {
                    Literal1.Text = "Upload status: The file could not be uploaded. The following error occured: " + ex.Message;
                }
            }






            SqlConnection sqlConnection = new SqlConnection();
            sqlConnection.ConnectionString = ConfigurationManager.ConnectionStrings["CrisTimeConnection"].ConnectionString;
           
            
           
            string connectionString = "Provider = Microsoft.ACE.OLEDB.12.0; Data Source = '"+ serverpath + "'; Extended Properties = 'Excel 8.0;HDR=Yes;IMEX=1'";
            try
            {
                OleDbConnection connection = new OleDbConnection(connectionString);
                connection.Open();
                
                OleDbCommand Slct = new OleDbCommand("SELECT marca,salar FROM [Sheet1$]", connection);
                OleDbDataReader readslct = Slct.ExecuteReader();
                

                while(readslct.Read())
                {
                    //int Marca, Salar;
                    string Marca =Convert.ToString( readslct.GetValue(0));
                    string Salar= Convert.ToString(readslct.GetValue(1));

                    SqlCommand sqlCommand = new SqlCommand("SetSalar", sqlConnection);
                    sqlCommand.CommandType = CommandType.StoredProcedure;


                    sqlCommand.Parameters.Add(new SqlParameter("@marca", Marca));
                    sqlCommand.Parameters.Add(new SqlParameter("@salar", Salar));
                    sqlCommand.Connection.Open();
                    try
                    {
                        sqlCommand.ExecuteNonQuery();
                        this.GridView1.DataBind();
                    }
                    catch (SqlException ex)
                    {
                        this.Literal1.Text = ex.Message + "<br /> eroare executie sql command <br /> marca:"+Marca.ToString()+" salar:"+Salar.ToString();
                    }
                    sqlCommand.Connection.Close();



                }
                connection.Close();
            }
            catch (OleDbException ex)
            {
                this.Literal1.Text = ex.Message + "eroeare excel"+ex.ToString();

            }


            


        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = this.GridView1.Rows[e.RowIndex];
            string card = e.NewValues["CARD"].ToString();
            string cd;
            Int64 cd1,cd2;
            cd1 = Convert.ToInt64(card);
            cd2 = cd1 & 4294967295;
            cd = Convert.ToString(cd2).Trim();

            ((TextBox)(row.Cells[5].Controls[0])).Text = cd;
            e.NewValues["CARD"] = cd;
            //this.GridView1.SelectedRow.Cells[5].Text = cd.ToString();
        }

        Int64 TrimCardNumber(Int64 cd)
        {
            return cd & 4294967295;
        }

    }
}
