<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="addlog.aspx.cs" Inherits="CrisTime.Reg.addlog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    <br />
    <asp:DropDownList ID="DropDownListAngajat" runat="server" DataSourceID="SqlDataSourceAng" DataTextField="NUME" DataValueField="MARCA"></asp:DropDownList>
    <asp:DropDownList ID="DropDownListTip" runat="server">
        <asp:ListItem Selected="True" Value="0">venire</asp:ListItem>
        <asp:ListItem Value="1">plecare</asp:ListItem>
    </asp:DropDownList>
    <asp:SqlDataSource ID="SqlDataSourceAng" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT [MARCA], [NUME] FROM [USER] ORDER BY [NUME]"></asp:SqlDataSource>
    <br />

    <table>
        <tr>
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
                <table>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Ziua</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Luna</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Anul</td>

                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="TextBoxZi" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBoxLuna" runat="server"></asp:TextBox>
                        </td>
                        <td>
                            <asp:TextBox ID="TextBoxAn" runat="server"></asp:TextBox>
                        </td>


                    </tr>
                </table>
            </td>
        </tr>
    </table>




    <div style="float: none;">
        <table>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Ora</td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  Minutul</td>

            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="TextBoxOra" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="TextBoxMinut" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:Button ID="ButtonAdd" runat="server" Text="Adauga" OnClick="ButtonAdd_Click" />
                </td>
            </tr>
        </table>
    </div>

</asp:Content>
