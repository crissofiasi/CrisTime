<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="intreruperi.aspx.cs" Inherits="CrisTime.Reg.intreruperi" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" DeleteCommand="DELETE FROM INTRERUPERI WHERE (line = @line)" SelectCommand="SELECT [USER].MARCA, [USER].NUME, NINTRERUP.DENUMIRE, INTRERUPERI.DATAINCEPUT, INTRERUPERI.DATASFARSIT, COMPANII.NUME AS Expr1, INTRERUPERI.line, dbo.ZileLucrF(INTRERUPERI.DATAINCEPUT, INTRERUPERI.DATASFARSIT) AS z_lucr, DATEDIFF(day, INTRERUPERI.DATAINCEPUT, INTRERUPERI.DATASFARSIT) + 1 AS z_calend FROM [USER] INNER JOIN INTRERUPERI ON [USER].MARCA = INTRERUPERI.MARCA INNER JOIN NINTRERUP ON INTRERUPERI.IdINTRERUP = NINTRERUP.IdINTRERUP INNER JOIN COMPANII ON [USER].IdCOMPANIE = COMPANII.IdCOMPANIE 	order by INTRERUPERI.DATAINCEPUT desc " OnSelecting="SqlDataSource1_Selecting">
        <DeleteParameters>
            <asp:Parameter Name="line" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceAng" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT [MARCA], [NUME] FROM [USER] ORDER BY [NUME]"></asp:SqlDataSource>
    <asp:SqlDataSource ID="SqlDataSourceINTR" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT DENUMIRE, IdINTRERUP FROM NINTRERUP"></asp:SqlDataSource>
    
    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    
    <br />
    <br />
    <br />
    <table border="1">
        <tr>
            <td  style="width: 280px; font-weight: bold; font-style: normal; font-size: medium; text-align: center;">Angajat</td>
            <td  style="width: 140px; font-weight: bold; font-style: normal; font-size: medium; text-align: center;">Tip intrerupere</td>
            <td style="width: 220px; font-weight: bold; font-style: normal; font-size: medium; text-align: center;">Data Inceput</td>
            <td style="width: 220px; font-weight: bold; font-style: normal; font-size: medium; text-align: center;">Data Sfarsit</td>
            <td style="width: 90px; font-weight: bold; font-style: normal; font-size: medium; text-align: center;">zile lucratoare</td>
            <td style="width: 90px; font-weight: bold; font-style: normal; font-size: medium; text-align: center;">zile calendaristice</td>
            <td style="width: 300px; font-weight: bold; font-style: normal; font-size: medium; text-align: center;"></td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DropDownListAngajat" runat="server" DataSourceID="SqlDataSourceAng" DataTextField="NUME" DataValueField="MARCA" Height="180px" Width="280px"></asp:DropDownList>
    
            </td>
            <td>
                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSourceINTR" DataTextField="DENUMIRE" DataValueField="IdINTRERUP" Height="180px" Width="140px"></asp:DropDownList>
    
            </td>
            <td>
                <asp:Calendar ID="Calendar1" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px" OnSelectionChanged="Calendar1_SelectionChanged">
        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
        <NextPrevStyle VerticalAlign="Bottom" />
        <OtherMonthDayStyle ForeColor="#808080" />
        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
        <SelectorStyle BackColor="#CCCCCC" />
        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
        <WeekendDayStyle BackColor="#FFFFCC" />
    </asp:Calendar>
    
            </td>

            <td>
                <asp:Calendar ID="Calendar2" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Width="200px" OnSelectionChanged="Calendar1_SelectionChanged">
        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
        <NextPrevStyle VerticalAlign="Bottom" />
        <OtherMonthDayStyle ForeColor="#808080" />
        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
        <SelectorStyle BackColor="#CCCCCC" />
        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
        <WeekendDayStyle BackColor="#FFFFCC" />
    </asp:Calendar>
    
            </td>
            <td style="font-size: x-large; font-weight: bold; text-align: center">
                <asp:Literal ID="LiteralLucratoare" runat="server" Text="..."></asp:Literal>
            </td>
            <td style="font-size: x-large; font-weight: bold; text-align: center">
                <asp:Literal ID="LiteralCalendaristice" runat="server" Text="..."></asp:Literal>
            </td>
            <td>
                <asp:Button ID="AddIntrerup" runat="server" Text="Adauga" OnCommand="AddIntrerup_Command" />
            </td>
        </tr>
    </table>

    <br />
    <br />


    <br />
    <br />
    <br />
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" DataKeyNames="line" AllowPaging="True" AllowSorting="True">
        <Columns>
            <asp:BoundField DataField="MARCA" HeaderText="MARCA" SortExpression="MARCA" ReadOnly="True" />
            <asp:BoundField DataField="NUME" HeaderText="NUME" SortExpression="NUME" />
            <asp:BoundField DataField="DENUMIRE" HeaderText="DENUMIRE" SortExpression="DENUMIRE" />
            <asp:BoundField DataField="DATAINCEPUT" HeaderText="DATAINCEPUT" SortExpression="DATAINCEPUT" />
            <asp:BoundField DataField="DATASFARSIT" HeaderText="DATASFARSIT" SortExpression="DATASFARSIT" />
            <asp:BoundField DataField="Expr1" HeaderText="Firma" SortExpression="Expr1" />
            <asp:BoundField DataField="line" HeaderText="line" InsertVisible="False" ReadOnly="True" SortExpression="line" Visible="false" />
            <asp:BoundField DataField="z_lucr" HeaderText="Zile Lucratoare" ReadOnly="True" SortExpression="z_lucr" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" >
            <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True"></ItemStyle>
            </asp:BoundField>
            <asp:BoundField DataField="z_calend" HeaderText="Zile Calendaristice" ReadOnly="True" SortExpression="z_calend" ItemStyle-HorizontalAlign="Center" ItemStyle-VerticalAlign="Middle" >
                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="50px" />
<ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Font-Bold="True"></ItemStyle>
            </asp:BoundField>
            <asp:CommandField DeleteText="Sterge" ShowDeleteButton="True" ShowEditButton="True" EditText="Modifica" />
            
        </Columns>

    </asp:GridView>

    <%--<asp:CommandField DeleteText="Sterge" ShowDeleteButton="True" ShowEditButton="True" EditText="Modifica" />--%>

    
</asp:Content>
