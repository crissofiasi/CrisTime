<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="sarbatori.aspx.cs" Inherits="CrisTime.Reg.sarbatori" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <asp:Literal ID="Literal1" runat="server"></asp:Literal>

    <table>
        <tr>
            <td>
                <asp:Calendar ID="Calendar1" runat="server" OnDayRender="Calendar1_DayRender"></asp:Calendar>
            </td>
            <td>
                <table>
                    <tr>
                        <td>
                            Denumire
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="TextBox_Denumire" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Button ID="Button_adauga" runat="server" Text="Adauga" OnCommand="Button_adauga_Command" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <br />
    <br />

    <asp:GridView ID="GridView1" runat="server" DataSourceId="SqlDataSource1" AutoGenerateColumns="False" DataKeyNames="id" OnRowDeleting="GridView1_RowDeleting" >
        <Columns>
            <asp:BoundField DataField="id" HeaderText="id" SortExpression="id" InsertVisible="False" ReadOnly="True" Visible="False" />
            <asp:BoundField DataField="nume" HeaderText="nume" SortExpression="nume" />
            <asp:BoundField DataField="data" HeaderText="data" SortExpression="data" />
            <asp:CommandField ShowDeleteButton="true" />

        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT [nume], [id], [data] FROM [SARBATORI]">
    </asp:SqlDataSource>
</asp:Content>
