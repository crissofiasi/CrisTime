<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ATTLOG.aspx.cs" Inherits="CrisTime.Reg.ATTLOG" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

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
                    <asp:ControlParameter Name="an" ControlId="DropDownListan" PropertyName="SelectedValue"/>
                    <asp:ControlParameter Name="luna" ControlId="DropDownListLuna" PropertyName="SelectedValue"/>
                    <asp:ControlParameter Name="zi" ControlId="DropDownListZi" PropertyName="SelectedValue"/>
                    <asp:ControlParameter Name="MARCA" ControlId="DropDownListMarca" PropertyName="SelectedValue"/>

                </FilterParameters>

                   <UpdateParameters>
                       <asp:Parameter Name="TIP" />
                       <asp:Parameter Name="DATAORA" />
                       <asp:Parameter Name="MARCA" />
                   </UpdateParameters>

</asp:SqlDataSource>


    
<%--    <asp:SqlDataSource ID="SqlDataSourceAN" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'an' UNION 
SELECT DISTINCT 
	   STR(DATEPART(year,DATEADD(DAY,-1*[TIP],[DATAORA]))) as an
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc"></asp:SqlDataSource>

                <asp:SqlDataSource ID="SqlDataSourceLuna" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'luna' UNION 
SELECT DISTINCT 
	   str(DATEPART(MONTH,DATEADD(DAY,-1*[TIP],[DATAORA]))) as luna
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc
"></asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSourceZi" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'zi' UNION 
SELECT DISTINCT 
	   str(DATEPART(DAY,DATEADD(DAY,-1*[TIP],[DATAORA]))) as zi
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc"></asp:SqlDataSource>--%>

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
    
<%--     <table >
        <tr>
            <td>ZI</td>
            <td>LUNA</td>
            <td>AN</td>
            <td>Nume </td>
        </tr>
        <tr>
            <td> <asp:DropDownList ID="DropDownListZi" runat="server" DataSourceID="SqlDataSourceZi" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True" ></asp:DropDownList></td>
            <td>
                <asp:DropDownList ID="DropDownListLuna" runat="server" DataSourceID="SqlDataSourceLuna" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True" ></asp:DropDownList>
            </td>
            <td> <asp:DropDownList
                id="DropDownListan"
                runat="server"
                AutoPostBack="True" DataSourceID="SqlDataSourceAN" DataTextField="Column1" DataValueField="Column1">
                <asp:ListItem Selected="True">an</asp:ListItem>
               
            </asp:DropDownList> 

            </td>
            <td>
                <asp:DropDownList ID="DropDownListMarca" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceNume" DataTextField="Column2" DataValueField="Column1"></asp:DropDownList>
            </td>
        </tr>
    </table>--%>

    
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
                    <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="White" BorderWidth="1px" Font-Names="Verdana" Font-Size="9pt" ForeColor="Black" Height="190px" NextPrevFormat="FullMonth" OnSelectionChanged="Calendar1_SelectionChanged" Width="350px">
                        <DayHeaderStyle Font-Bold="True" Font-Size="8pt" />
                        <NextPrevStyle Font-Bold="True" Font-Size="8pt" ForeColor="#333333" VerticalAlign="Bottom" />
                        <OtherMonthDayStyle ForeColor="#999999" />
                        <SelectedDayStyle BackColor="#333399" ForeColor="White" />
                        <TitleStyle BackColor="White" BorderColor="Black" BorderWidth="4px" Font-Bold="True" Font-Size="12pt" ForeColor="#333399" />
                        <TodayDayStyle  BorderStyle="Solid" BorderColor="Red" />
                        <WeekendDayStyle BackColor="#FFFFCC" />
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
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="MARCA,DATAORA" PageSize="50">
        <Columns>
            <asp:CommandField ShowEditButton="True" CancelText="Renunta" UpdateText="Actualizeaza" >
            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
            </asp:CommandField>
            <asp:BoundField DataField="MARCA" HeaderText="MARCA" ReadOnly="True" SortExpression="MARCA" >
            <ItemStyle Width="60px" />
            </asp:BoundField>
            <asp:BoundField DataField="NUME" HeaderText="NUME" SortExpression="NUME" ReadOnly="True" >
            <ItemStyle Width="160px" />
            </asp:BoundField>
            <asp:BoundField DataField="DATAORA" HeaderText="DATAORA" ReadOnly="True" SortExpression="DATAORA" >
            <ItemStyle Width="150px" Wrap="True" />
            </asp:BoundField>
            <asp:BoundField DataField="TIP" HeaderText="TIP" SortExpression="TIP" >
            <ItemStyle Font-Bold="True" HorizontalAlign="Center" Width="30px" />
            </asp:BoundField>
            <asp:BoundField DataField="zi" HeaderText="zi" ReadOnly="True" SortExpression="zi" InsertVisible="False" Visible="False" />
            <asp:BoundField DataField="luna" HeaderText="luna" ReadOnly="True" SortExpression="luna" Visible="False" />
            <asp:BoundField DataField="an" HeaderText="an" ReadOnly="True" SortExpression="an" Visible="False" />
        </Columns>
    </asp:GridView>
</asp:Content>
