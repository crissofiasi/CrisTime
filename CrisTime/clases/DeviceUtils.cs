using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Configuration;
using System.Data.SqlClient;
using zkemkeeper;

namespace CrisTime.clases
{
    public class DeviceUtils
    {
        private struct linie
        {

            public string str;
            public int num;
            public int num1;
            public int num2;
            public int num3;
            public int num4;
            public int num5;
            public int num6;
            public int num7;
            public int num8;
            public int num9;
            public int num10;
        }
        public string msg;
        private bool conectToDevice(string str, CZKEMClass cZKEMClass, ref int num1)
        {
            bool ok;
            if (!cZKEMClass.Connect_Net(str.ToString(), 4370))
            {
                cZKEMClass.GetLastError(ref num1);
                this.msg = string.Concat(msg,@"<br />Unable to connect the device,ErrorCode=", num1.ToString());
                ok = false;
            }
            else
            {
                this.msg = string.Concat(msg,@"<br />Connected to device!");
                cZKEMClass.RegEvent(1, 65535);
                ok = true;

            }
            return ok;
        }
        private void ImportRecords(CZKEMClass axCZKEM1, int iMachineNumber, string con)
        {
            string str = "";
            int num = 0,num1 = 0,num2 = 0,num3 = 0,num4 = 0,num5 = 0,num6 = 0,num7 = 0,num8 = 0,num9 = 0,num10 = 0;
            List<linie> ListReccords = new List<linie>();
            List<linie> ListReccordsImported = new List<linie>();
            HashSet<ulong> HSetImportedKeys = new HashSet<ulong>();
            SqlConnection sqlConnection0 = new SqlConnection(con);
            sqlConnection0.Open();
            string str2 = string.Concat(new string[] { "select year(DATAORA),MONTH(DATAORA),DAY(DATAORA), DATEPART(Hh, DATAORA), DATEPART(n, DATAORA), DATEPART(s, DATAORA) FROM ATTLOG" });
            SqlCommand sqlCommand1 = new SqlCommand(str2, sqlConnection0);
            SqlDataReader reader = sqlCommand1.ExecuteReader();
            this.msg = string.Concat(msg, @"<br /> reader ok (already imported keys) ");
            bool hr = reader.HasRows;
            int year = 0, month = 0;
            if (hr)
            {
                while (reader.Read())
                {
                    linie ir = new linie();
                    ir.num2 = reader.GetInt32(0);
                    ir.num3 = reader.GetInt32(1);
                    ir.num4 = reader.GetInt32(2);
                    ir.num5 = reader.GetInt32(3);
                    ir.num6 = reader.GetInt32(4);
                    ir.num7 = reader.GetInt32(5);
                    ulong key = (ulong)(ir.num2 * 10000000000 +
                                ir.num3 * 100000000 +
                                ir.num4 * 1000000 +
                                ir.num5 * 10000 +
                                ir.num6 * 100 +
                                ir.num7 * 1);
                    if (year * 100 + month < ir.num2 * 100 + ir.num3)
                    { year = ir.num2; month = ir.num3; }
                    HSetImportedKeys.Add(key);
                }
            }
            this.msg = string.Concat(msg, @"<br /> Already imported keys loaded ");
            reader.Close();
            //this.msg = string.Concat(msg, @"<br /> reader closed ");
            month -= 6;
            if (month < 1)
            {
                month = +12;
                year--;
            }
            sqlConnection0.Close();
            int n1 = 0;
            bool ok;
            string strConn = ConfigurationManager.ConnectionStrings["IP"].ConnectionString;
            ok = conectToDevice(strConn, axCZKEM1, ref n1);
            if (ok)
            {
                axCZKEM1.EnableDevice(iMachineNumber, false);
                bool flag = axCZKEM1.ReadLastestLogData(iMachineNumber, 1, year, month, 1, 0, 0, 0);
                this.msg = string.Concat(msg, @"<br /> read finished");
                axCZKEM1.EnableDevice(iMachineNumber, true);
                if (flag)
                {
                    SqlConnection sqlConnection = new SqlConnection(con);
                    try
                    {
                        while (axCZKEM1.SSR_GetGeneralLogData(iMachineNumber, out str, out num, out num1, out num2, out num3, out num4, out num5, out num6, out num7, ref num8))
                        {
                            num9++;
                            linie l = new linie();
                            l.str = str;
                            l.num = num;
                            l.num1 = num1;
                            l.num2 = num2;
                            l.num3 = num3;
                            l.num4 = num4;
                            l.num5 = num5;
                            l.num6 = num6;
                            l.num7 = num7;
                            l.num8 = num8;
                            l.num9 = num9;
                            l.num10 = num10;
                            num10++;
                            ulong key = (ulong)(l.num2 * 10000000000 +
                                   l.num3 * 100000000 +
                                   l.num4 * 1000000 +
                                   l.num5 * 10000 +
                                   l.num6 * 100 +
                                   l.num7 * 1);
                            bool ex = HSetImportedKeys.Contains(key);
                            if (!ex)
                                ListReccords.Add(l);
                        }
                        axCZKEM1.Disconnect();
                        this.msg = string.Concat(msg, @"<br /> New log list ready, device disconnected! ");
                        if (!ListReccords.Any())
                        {
                            this.msg = string.Concat(msg, @"<br /> Log list empty. Nothing to import! ");

                            return;
                        }
                        sqlConnection.Open();
                        this.msg = string.Concat(msg, @"<br /> Connection Open ! (SQL) ");
                        foreach (linie li in ListReccords)
                        {
                            str = li.str;
                            num = li.num;
                            num1 = li.num1;
                            num2 = li.num2;
                            num3 = li.num3;
                            num4 = li.num4;
                            num5 = li.num5;
                            num6 = li.num6;
                            num7 = li.num7;
                            num8 = li.num8;
                            num9 = li.num9;
                            num10 = li.num10;
                            string str1 = string.Concat(new string[] { "INSERT INTO ATTLOG (MARCA,DATAORA,TIP) VALUES (", str, ",'", num2.ToString(), "-", num3.ToString().PadLeft(2, '0'), "-", num4.ToString().PadLeft(2, '0'), " ", num5.ToString(), ":", num6.ToString(), ":", num7.ToString(), "',", num1.ToString(), ") " });
                            string strMsg = string.Concat(new string[] { @"<br /> -->", str, ",'", num2.ToString(), "-", num3.ToString().PadLeft(2, '0'), "-", num4.ToString().PadLeft(2, '0'), " ", num5.ToString(), ":", num6.ToString(), ":", num7.ToString(), "',", num1.ToString() });

                            SqlCommand sqlCommand = new SqlCommand(str1, sqlConnection);
                            if (num2 * 10000 + num3 * 100 + num4 > 20161103)
                            {
                                Console.WriteLine(str1);
                                try
                                {
                                    sqlCommand.ExecuteNonQuery();
                                    this.msg = string.Concat(msg, strMsg);
                                }
                                catch (Exception exception)
                                {
                                    this.msg = string.Concat(msg, exception.Message.ToString());
                                }
                            }
                        }
                        sqlConnection.Close();
                       msg = string.Concat(msg,  @"<br /> Connection closed (SQL)" );
                    }
                    catch (Exception exception2)
                    {
                        Exception exception1 = exception2;
                        this.msg = string.Concat(msg, @"<br />Can not open connection ! ");
                        this.msg = string.Concat(msg, exception1.Message.ToString());
                    }
                }
            }
        }
        public  void ImportRecordsFromDevice ()
        {
            string connectionString = @"Data Source=10.10.10.26\PRI;Initial Catalog=CrisTime;Persist Security Info=True;User ID=tabula;Password=tabula~!2";
                   connectionString = ConfigurationManager.ConnectionStrings["Cnn"].ConnectionString;
            string str = ConfigurationManager.ConnectionStrings["IP"].ConnectionString;

            Console.WriteLine(connectionString);
            CZKEMClass cZKEMClass = new CZKEMClass();
            int num = 1;
            int num1 = 0;
            num = 1;
            ImportRecords(cZKEMClass, num, connectionString);
        }
    }
}