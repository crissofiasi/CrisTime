<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="condica.aspx.cs" Inherits="CrisTime.Reg.condica" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:SqlDataSource ID="SqlDataSourceCondica" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="CONDICA"
        FilterExpression="an={0} and luna={1} and zi={2} and MARCA={3}" SelectCommandType="StoredProcedure" UpdateCommand="InsertCorectii" UpdateCommandType="StoredProcedure">
        <FilterParameters>
            <asp:ControlParameter Name="an" ControlID="DropDownListan" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="luna" ControlID="DropDownListLuna" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="zi" ControlID="DropDownListZi" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="MARCA" ControlID="DropDownListMarca" PropertyName="SelectedValue" />

        </FilterParameters>
        <UpdateParameters>
            <asp:Parameter Name="marca" Type="Int64" />
            <asp:Parameter Name="an" Type="Int32" />
            <asp:Parameter Name="luna" Type="Int32" />
            <asp:Parameter Name="zi" Type="Int32" />
            <asp:Parameter Name="REDUCERI" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSourceAN" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'an' UNION 
SELECT DISTINCT 
	   right('      '+rtrim(STR(DATEPART(year,DATEADD(DAY,-1*[TIP],[DATAORA])))),4) as an
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceLuna" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="
        SELECT 'luna' UNION 
SELECT DISTINCT 
	   right('   '+rtrim(str(DATEPART(MONTH,DATEADD(DAY,-1*[TIP],[DATAORA])))),2) as luna
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc
"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceZi" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'zi' UNION 
SELECT DISTINCT 
	    right('  '+rtrim(str(DATEPART(DAY,DATEADD(DAY,-1*[TIP],[DATAORA])))),2) as zi
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceNume" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'MARCA','Toti Angajatii',0 union
select str(MARCA), NUME,1
from [USER]
order by 3,2"></asp:SqlDataSource>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT [USER].[MARCA] as MARCA
	  ,[USER].NUME 
      ,[DATAORA]
      ,[TIP]
	  ,DAY([DATAORA]) AS zi
	  ,MONTH([DATAORA]) AS luna
	  ,YEAR([DATAORA]) AS an
  FROM [CrisTime].[dbo].[ATTLOG]
  JOIN [USER] ON [USER].[MARCA]=[ATTLOG].MARCA
"
        FilterExpression="an={0} and luna={1} and zi={2} and MARCA={3}" UpdateCommand="UPDATE [ATTLOG]
SET TIP=@TIP WHERE DATAORA=@DATAORA AND MARCA=@MARCA">

        <FilterParameters>
            <asp:ControlParameter Name="an" ControlID="GridView1" PropertyName="SelectedDataKey[3]" DefaultValue="0" />
            <asp:ControlParameter Name="luna" ControlID="GridView1" PropertyName="SelectedDataKey[2]" DefaultValue="0" />
            <asp:ControlParameter Name="zi" ControlID="GridView1" PropertyName="SelectedDataKey[1]" DefaultValue="0" />
            <asp:ControlParameter Name="MARCA" ControlID="GridView1" PropertyName="SelectedDataKey[0]" DefaultValue="0" />

        </FilterParameters>

        <UpdateParameters>
            <asp:Parameter Name="TIP" />
            <asp:Parameter Name="DATAORA" />
            <asp:Parameter Name="MARCA" />
        </UpdateParameters>

    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlLogFormatii" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SelectFormatii" UpdateCommand="InsertLogFormatii" UpdateCommandType="StoredProcedure" SelectCommandType="StoredProcedure">

        <SelectParameters>
            <asp:ControlParameter Name="marca" ControlID="GridView1" PropertyName="SelectedDataKey[0]" DefaultValue="0" />

            <asp:ControlParameter Name="zi" ControlID="GridView1" PropertyName="SelectedDataKey[1]" DefaultValue="0" />
            <asp:ControlParameter Name="luna" ControlID="GridView1" PropertyName="SelectedDataKey[2]" DefaultValue="0" />
            <asp:ControlParameter Name="an" ControlID="GridView1" PropertyName="SelectedDataKey[3]" DefaultValue="0" />

        </SelectParameters>



        <UpdateParameters>
            <asp:Parameter Name="marca" Type="Int64" />
            <asp:Parameter Name="fid" Type="Int64" />
            <asp:Parameter Name="timp" Type="Int64" />
            <asp:Parameter Name="obs" Type="String" />
            <asp:Parameter Name="an" Type="Int32" />
            <asp:Parameter Name="luna" Type="Int32" />
            <asp:Parameter Name="zi" Type="Int32" />
        </UpdateParameters>



    </asp:SqlDataSource>




    <div style="position: relative; overflow: auto; width: 100%">



        <asp:Literal ID="Literal1" runat="server"></asp:Literal>
        <br />
        <asp:Literal ID="Literal2" runat="server"></asp:Literal>
        <br />



        <br />

        <asp:Button ID="ButtonRefresh" runat="server" Text="Refresh" OnClick="ButtonRefresh_Click" />
        <asp:Button ID="btnImportRecords" runat="server" Text="Import from device" OnClick="btnImportRecords_Click" CssClass="working_btn" />
        <br />

        <table>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td>ZI</td>
                            <td>LUNA</td>
                            <td>AN</td>

                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="DropDownListZi" runat="server" DataSourceID="SqlDataSourceZi" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True" OnSelectedIndexChanged="DATE_SelectedIndexChanged"></asp:DropDownList></td>
                            <td>
                                <asp:DropDownList ID="DropDownListLuna" runat="server" DataSourceID="SqlDataSourceLuna" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True" OnSelectedIndexChanged="DATE_SelectedIndexChanged"></asp:DropDownList>
                            </td>
                            <td>
                                <asp:DropDownList
                                    ID="DropDownListan"
                                    runat="server"
                                    AutoPostBack="True" DataSourceID="SqlDataSourceAN" DataTextField="Column1" DataValueField="Column1" OnSelectedIndexChanged="DATE_SelectedIndexChanged">
                                    <asp:ListItem Selected="True">an</asp:ListItem>

                                </asp:DropDownList>

                            </td>
                        </tr>
                    </table>
                </td>

            </tr>
            <tr>
                <td>
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" OnSelectionChanged="Calendar1_SelectionChanged" Width="350px" OnDayRender="Calendar1_DayRender">
                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                        <TodayDayStyle  BorderStyle="Solid" BorderColor="Red" />
                        <WeekendDayStyle BackColor="#FFAA88" ForeColor="Red" />
                    </asp:Calendar>
                </td>
                <td>
                    <table>
                        <tr>
                            <td>Nume </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:DropDownList ID="DropDownListMarca" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceNume" DataTextField="Column2" DataValueField="Column1"></asp:DropDownList>
                            </td>

                        </tr>
                    </table>

                </td>
            </tr>
        </table>

        <br />
    </div>
    <asp:Panel ID="Panel1" runat="server">
        <div style="float: left; overflow: auto; position: relative; width: 50%">

            <%--  <asp:GridView ID="GridView3" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSourceCondica" PageSize="50" DataKeyNames="marca,zi,luna,an" OnRowDataBound="GridView1_RowDataBound">--%>
            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" BackColor="White" BorderColor="#999999" BorderStyle="None" BorderWidth="1px" CellPadding="3" DataSourceID="SqlDataSourceCondica" PageSize="50" DataKeyNames="marca,zi,luna,an,NUME,ORE" OnRowDataBound="GridView1_RowDataBound" OnSelectedIndexChanging="GridView1_SelectedIndexChanging" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnDataBound="GridView1_DataBound">
                <AlternatingRowStyle BackColor="Gainsboro" />
                <Columns>
                    <asp:CommandField ShowSelectButton="True" SelectImageUrl="../images/selectright.png" ButtonType="Image" ControlStyle-Width="15px" />
                    <asp:BoundField DataField="marca" HeaderText="marca" ReadOnly="True" SortExpression="marca" Visible="false" />
                    <asp:BoundField DataField="NUME" HeaderText="NUME" ReadOnly="True" SortExpression="NUME" />
                    <asp:BoundField DataField="an" HeaderText="an" ReadOnly="True" SortExpression="an" />
                    <asp:BoundField DataField="luna" HeaderText="luna" ReadOnly="True" SortExpression="luna" />
                    <asp:BoundField DataField="zi" HeaderText="zi" ReadOnly="True" SortExpression="zi" />
                    <asp:BoundField DataField="VENIRE" HeaderText="VENIRE" ReadOnly="True" SortExpression="VENIRE" />
                    <asp:BoundField DataField="PLECARE" HeaderText="PLECARE" ReadOnly="True" SortExpression="PLECARE" />
                    <asp:BoundField DataField="ORE" HeaderText="ORE" ReadOnly="True" SortExpression="ORE" ApplyFormatInEditMode="False" DataFormatString="{0:F0}" />
                    <asp:BoundField DataField="REDUCERI" HeaderText="Ore Corec tat" ReadOnly="False" SortExpression="corectie" ItemStyle-Width="20px" HeaderStyle-Wrap="True" HeaderStyle-Width="20px" InsertVisible="True" ControlStyle-Width="20px" />
                    <asp:CommandField ShowEditButton="true" ItemStyle-Width="5px" ControlStyle-Width="20px" ButtonType="Image" CancelImageUrl="../images/cancel.png" EditImageUrl="../images/Edit.png" UpdateImageUrl="../images/check.png" Visible="false" />

                </Columns>
                <FooterStyle BackColor="#CCCCCC" ForeColor="Black" />
                <HeaderStyle BackColor="#000084" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#999999" ForeColor="Black" HorizontalAlign="Center" />
                <RowStyle BackColor="#EEEEEE" ForeColor="Black" />
                <SelectedRowStyle BackColor="#008A8C" Font-Bold="True" ForeColor="White" />
                <SortedAscendingCellStyle BackColor="#F1F1F1" />
                <SortedAscendingHeaderStyle BackColor="#0000A9" />
                <SortedDescendingCellStyle BackColor="#CAC9C9" />
                <SortedDescendingHeaderStyle BackColor="#000065" />

            </asp:GridView>
            <br />

            <asp:Button ID="Expexcel" runat="server" Text="To Excel" OnClick="Expexcel_Click" />
            <br />


            <asp:Literal ID="LitMsg" runat="server"></asp:Literal>

        </div>
        <div style="padding: 10px; position: relative; width: 50%; float: left; overflow: auto">
            <div style="text-align: center">
                <h2>
                    <asp:Literal ID="LiteralAngajat" runat="server"></asp:Literal>

                </h2>
            </div>
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="fid,marca,zi,luna,an" DataSourceID="SqlLogFormatii" OnRowDataBound="GridView3_RowDataBound" OnRowUpdating="GridView3_RowUpdating" ShowFooter="true">
                <Columns>
                    <asp:CommandField EditText="Modifica" ShowEditButton="True" />
                    <asp:BoundField DataField="FORMATIE" HeaderText="Formatie" ReadOnly="True" SortExpression="FORMATIE" />
                    <asp:BoundField DataField="fid" HeaderText="fid" InsertVisible="False" ReadOnly="True" SortExpression="fid" Visible="false" />
                    <asp:BoundField DataField="marca" HeaderText="marca" ReadOnly="True" SortExpression="marca" Visible="false" />
                    <asp:BoundField ControlStyle-Width="50px" DataField="timp" FooterStyle-HorizontalAlign="Center" HeaderStyle-HorizontalAlign="Center" HeaderText="Timp (ore)" ItemStyle-HorizontalAlign="Center" ItemStyle-Width="50px" SortExpression="timp" />
                    <asp:BoundField ControlStyle-Width="300px" DataField="obs" HeaderText="Observatii" ItemStyle-Width="300px" SortExpression="obs" />
                    <asp:BoundField DataField="zi" HeaderText="zi" ReadOnly="True" SortExpression="zi" Visible="false" />
                    <asp:BoundField DataField="luna" HeaderText="luna" ReadOnly="True" SortExpression="luna" Visible="false" />
                    <asp:BoundField DataField="an" HeaderText="an" ReadOnly="True" SortExpression="an" Visible="false" />
                </Columns>
                <FooterStyle BackColor="#cccccc" Font-Bold="True" />
                <HeaderStyle BackColor="#cccccc" Font-Bold="True" />
            </asp:GridView>
            <br />
            <h3>
                <asp:Literal ID="LiteralScanari" runat="server"></asp:Literal>
            </h3>
            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="MARCA,DATAORA" DataSourceID="SqlDataSource1" OnRowDataBound="GridView2_RowDataBound">
                <Columns>
                    <asp:CommandField CancelText="Renunta" ShowEditButton="True" UpdateText="Actualizeaza">
                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                    </asp:CommandField>
                    <asp:BoundField DataField="MARCA" HeaderText="MARCA" ReadOnly="True" SortExpression="MARCA">
                        <ItemStyle Width="60px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="NUME" HeaderText="NUME" ReadOnly="True" SortExpression="NUME">
                        <ItemStyle Width="160px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="DATAORA" HeaderText="DATAORA" ReadOnly="True" SortExpression="DATAORA">
                        <ItemStyle Width="150px" Wrap="True" />
                    </asp:BoundField>
                    <asp:BoundField DataField="TIP" HeaderText="TIP" SortExpression="TIP">
                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="30px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="zi" HeaderText="zi" InsertVisible="False" ReadOnly="True" SortExpression="zi" Visible="False" />
                    <asp:BoundField DataField="luna" HeaderText="luna" ReadOnly="True" SortExpression="luna" Visible="False" />
                    <asp:BoundField DataField="an" HeaderText="an" ReadOnly="True" SortExpression="an" Visible="False" />
                </Columns>
            </asp:GridView>
            TIP = 0 : VENIRE
                <br />
            TIP = 1 : PLECARE

                

            



            




 


        </div>
    </asp:Panel>

</asp:Content>
