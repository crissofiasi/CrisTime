<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="pontaj.aspx.cs" Inherits="CrisTime.Reg.pontaj" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:SqlDataSource ID="SqlDataSourcepontaj" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT PONTAJ.MARCA, [USER].NUME, PONTAJ.LUNA AS luna, PONTAJ.AN AS an, PONTAJ.[1], PONTAJ.[2], PONTAJ.[3], PONTAJ.[4], PONTAJ.[5], PONTAJ.[6], PONTAJ.[7], PONTAJ.[8], PONTAJ.[9], PONTAJ.[10], PONTAJ.[11], PONTAJ.[12], PONTAJ.[13], PONTAJ.[14], PONTAJ.[16], PONTAJ.[15], PONTAJ.[17], PONTAJ.[18], PONTAJ.[19], PONTAJ.[20], PONTAJ.[21], PONTAJ.[22], PONTAJ.[23], PONTAJ.[24], PONTAJ.[25], PONTAJ.[26], PONTAJ.[27], PONTAJ.[28], PONTAJ.[29], PONTAJ.[30], PONTAJ.[31], COMPANII.NUME AS FIRMA, COMPANII.IdCOMPANIE AS comp FROM PONTAJ INNER JOIN [USER] ON PONTAJ.MARCA = [USER].MARCA INNER JOIN COMPANII ON [USER].IdCOMPANIE = COMPANII.IdCOMPANIE ORDER BY an, luna, [USER].NUME"
        FilterExpression="an={0} and luna={1} and comp={2} and MARCA={3}">
        <FilterParameters>
            <asp:ControlParameter Name="an" ControlID="DropDownListan" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="luna" ControlID="DropDownListLuna" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="comp" ControlID="DropDownfirma" PropertyName="SelectedValue" />
            <asp:ControlParameter Name="MARCA" ControlID="DropDownListMarca" PropertyName="SelectedValue" />


        </FilterParameters>

    </asp:SqlDataSource>


    <asp:SqlDataSource ID="SqlDataSourceAN" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'an' UNION 
SELECT DISTINCT 
	   rtrim(ltrim(STR(DATEPART(year,DATEADD(DAY,-1*[TIP],[DATAORA]))))) as an
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceLuna" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'luna' UNION 
SELECT DISTINCT 
	   ltrim(rtrim(str(DATEPART(MONTH,DATEADD(DAY,-1*[TIP],[DATAORA]))))) as luna
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc
"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceZi" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'zi' UNION 
SELECT DISTINCT 
	   str(DATEPART(DAY,DATEADD(DAY,-1*[TIP],[DATAORA]))) as zi
	    FROM [CrisTime].[dbo].[ATTLOG] 
		order by 1 desc"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceNume" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" SelectCommand="SELECT 'MARCA','Toti Angajatii',0 union
select str(MARCA), NUME,1
from [USER]
order by 3,2"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourcefirma" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT [IdCOMPANIE], [NUME] FROM [COMPANII]"></asp:SqlDataSource>

    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    <br />

    <asp:Button ID="ButtonCalc" runat="server" Text="Recalculeaza" OnClick="ButtonCalc_Click" CssClass="working_btn"/>


    <table>
        <tr>
            <td>LUNA</td>
            <td>AN</td>
            <td>Nume </td>
            <td>firma</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DropDownListLuna" runat="server" DataSourceID="SqlDataSourceLuna" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True"></asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList
                    ID="DropDownListan"
                    runat="server"
                    AutoPostBack="True" DataSourceID="SqlDataSourceAN" DataTextField="Column1" DataValueField="Column1">
                    <asp:ListItem Selected="True">an</asp:ListItem>

                </asp:DropDownList>

            </td>
            <td>
                <asp:DropDownList ID="DropDownListMarca" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceNume" DataTextField="Column2" DataValueField="Column1"></asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="DropDownfirma" runat="server" DataSourceID="SqlDataSourcefirma" DataTextField="NUME" DataValueField="IdCOMPANIE" AutoPostBack="true"></asp:DropDownList>

            </td>
        </tr>
    </table>
    <hr />
    <asp:Panel ID="Panel1" runat="server">


        <br />
        <h2 style="text-align: left">
            <asp:Literal ID="LiteralFirma" runat="server"></asp:Literal>
        </h2>

        <h2 style="text-align: center">Pontaj
                        <asp:Literal ID="LiteralLuna" runat="server"></asp:Literal>
            <asp:Literal ID="LiteralAn" runat="server"></asp:Literal>
        </h2>
        <br />
        <asp:GridView ID="GridViewPontaj" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcepontaj" AllowSorting="false" OnRowDataBound="GridViewPontaj_RowDataBound">
            <Columns>
                <asp:BoundField DataField="MARCA" HeaderText="MARCA" SortExpression="MARCA" />
                <asp:BoundField DataField="NUME" HeaderText="NUME" SortExpression="NUME" />
                <asp:BoundField DataField="luna" HeaderText="luna" SortExpression="luna" />
                <asp:BoundField DataField="an" HeaderText="an" SortExpression="an" />
                <asp:BoundField DataField="1" HeaderText="1" SortExpression="1" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="2" HeaderText="2" SortExpression="2" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="3" HeaderText="3" SortExpression="3" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="4" HeaderText="4" SortExpression="4" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="5" HeaderText="5" SortExpression="5" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="6" HeaderText="6" SortExpression="6" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="7" HeaderText="7" SortExpression="7" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="8" HeaderText="8" SortExpression="8" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="9" HeaderText="9" SortExpression="9" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="10" HeaderText="10" SortExpression="10" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="11" HeaderText="11" SortExpression="11" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="12" HeaderText="12" SortExpression="12" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="13" HeaderText="13" SortExpression="13" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="14" HeaderText="14" SortExpression="14" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="15" HeaderText="15" SortExpression="15" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="16" HeaderText="16" SortExpression="16" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="17" HeaderText="17" SortExpression="17" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="18" HeaderText="18" SortExpression="18" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="19" HeaderText="19" SortExpression="19" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="20" HeaderText="20" SortExpression="20" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="21" HeaderText="21" SortExpression="21" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="22" HeaderText="22" SortExpression="22" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="23" HeaderText="23" SortExpression="23" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="24" HeaderText="24" SortExpression="24" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="25" HeaderText="25" SortExpression="25" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="26" HeaderText="26" SortExpression="26" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="27" HeaderText="27" SortExpression="27" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="28" HeaderText="28" SortExpression="28" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="29" HeaderText="29" SortExpression="29" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="30" HeaderText="30" SortExpression="30" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="31" HeaderText="31" SortExpression="31" HeaderStyle-Width="20px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField HeaderText="Total" HeaderStyle-Width="40px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                    <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="FIRMA" HeaderText="FIRMA" SortExpression="FIRMA" Visible="false" />
                <asp:BoundField DataField="comp" HeaderText="comp" SortExpression="comp" Visible="false" />
            </Columns>
        </asp:GridView>
        <br />

        <h2 style="text-align: center">
            Intocmit,
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Aprobat,
        </h2>
        <br />



    </asp:Panel>
    <asp:Button ID="Expexcel" runat="server" Text="To Excel" OnClick="Expexcel_Click" />

</asp:Content>
