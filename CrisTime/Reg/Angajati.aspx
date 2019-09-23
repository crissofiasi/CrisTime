<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Angajati.aspx.cs" Inherits="CrisTime.Reg.Angajati" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <BR />
    <div style="float: left">
    
    Fisier excel salarii : <asp:FileUpload ID="FileUpload1" runat="server" Width="219px" /> <asp:Button ID="ActualizareSalar" runat="server" Text="Actualizeaza Salar" OnClick="ActualizareSalar_Click" Width="220px" />
    
        </div>
    <BR />
    <div style="border-style: dashed; border-width: thin; float: right">
        <strong>Legenda TipManop </strong><br /> 
        1: Manopera directa <br />
        2: Manopera Indirecta <br />
        3: Ch. Generale <br />
    </div>
    <BR />
    <br />
    <br />
    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    <table>
    <tbody>
        
        <tr>
        <td>
    <table border="1" >
        <thead>
            <tr>
                <td>
                   <asp:Label ID="LabelMarca" runat="server" Text="   MARCA" Height="23px" Width="79px"></asp:Label>
                </td>
                <td>
                   <asp:Label ID="LabelNume" runat="server" Text="   Numele si prenumele" Height="23px" Width="139px"></asp:Label>
                </td>
                <td>
                   <asp:Label ID="LabelData_ang" runat="server" Text="    Data Angajarii" Height="23px" Width="129px"></asp:Label>
                </td>
                <td>
                   <asp:Label ID="LabelCNP" runat="server" Text="  CNP" Height="23px" Width="124px"></asp:Label>
                </td>
                <td>
                   <asp:Label ID="LabelComp" runat="server" Text="  Companie" Height="23px" Width="198px"></asp:Label>
                </td>
                <td>
                   <asp:Label ID="Label1" runat="server" Text="  CARD" Height="23px" Width="124px"></asp:Label>
                </td>
                
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>
                  <asp:TextBox ID="TextMarca" runat="server"  Width="68px"></asp:TextBox>
                </td>
                <td>
                   <asp:TextBox ID="TextNume" runat="server"  Width="143px"></asp:TextBox>
                </td>
                <td>
                   <asp:TextBox ID="TextData_ang" runat="server"  Width="122px"></asp:TextBox>
                </td>
                <td>
                  <asp:TextBox ID="TextCNP" runat="server"  Width="116px"></asp:TextBox>
                </td>
                <td>
                  <asp:DropDownList ID="DropDownListComp" runat="server" Width="200px" DataSourceID="SqlDataSourceComp" DataTextField="NUME" DataValueField="IdCOMPANIE"></asp:DropDownList>
                </td>
                <td>
                  <asp:TextBox ID="TextCARD" runat="server"  Width="116px"></asp:TextBox>
                </td>
                    
            </tr>
        </tbody>
    </table>
        </td>
        <td>
            <br />
            <asp:Button ID="ButtonAdd" runat="server" Text="Adauga" OnClick="ButtonAdd_Click" />
        </td>
            </tr>
    </tbody>
    </table>    
    <asp:Literal ID="Literal2" runat="server"></asp:Literal>

    <BR />
    <BR />
     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" EmptyDataText="There are no data records to display." DataKeyNames="MARCA" AllowPaging="True" AllowSorting="True" PageSize="50" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" OnRowUpdating="GridView1_RowUpdating" >
        <Columns>
            <asp:BoundField DataField="MARCA" HeaderText="MARCA" SortExpression="MARCA" ReadOnly="True"  />
            <asp:BoundField DataField="NUME" HeaderText="NUME" SortExpression="NUME" ReadOnly="false"/>
            <asp:BoundField DataField="COMPANIE" HeaderText="COMPANIE" SortExpression="COMPANIE" ReadOnly="True"/>
            <asp:BoundField DataField="DATA_ANG" HeaderText="DATA_ANG" SortExpression="DATA_ANG" ReadOnly="True"/>
            <asp:BoundField DataField="CNP" HeaderText="CNP" SortExpression="CNP" ReadOnly="True"/>
            <asp:BoundField DataField="CARD" HeaderText="NR. CARD" SortExpression="CARD" />
            <asp:BoundField DataField="TipManop" HeaderText="TipManop" SortExpression="TipManop" />
            <asp:BoundField DataField="Salar" HeaderText="Salar" SortExpression="Salar" />

            <asp:CommandField ShowDeleteButton="true" ShowSelectButton="true"  SelectText="UpdateDevice" ShowEditButton="true" ControlStyle-CssClass="working_btn" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnectionString1 %>" 
        SelectCommand="SELECT [USER].[MARCA] AS MARCA
      ,[USER].[NUME] AS NUME
      ,COMPANII.NUME AS COMPANIE
      ,[USER].[DATA_ANG] AS DATA_ANG
      ,[USER].[CNP] AS CNP
        ,[USER].[CARD] AS CARD
        ,[USER].[TipManop] AS TipManop,
        [USER].[Salar] AS Salar

  FROM [CrisTime].[dbo].[USER] JOIN COMPANII ON [USER].IdCOMPANIE=COMPANII.IdCOMPANIE" DeleteCommand="DELETE FROM [USER] WHERE (MARCA = @MARCA)" UpdateCommand="UPDATE [USER] SET CARD = @CARD, NUME = @NUME,Salar=@Salar,TipManop=@TipManop WHERE (MARCA = @MARCA)" 
      >
        <DeleteParameters>
            <asp:Parameter Name="MARCA" Type="Int32" />
        </DeleteParameters>
        

        <UpdateParameters>
            <asp:Parameter Name="CARD" Type="String"/>
            <asp:Parameter Name="NUME" Type="String"/>
            <asp:Parameter Name="MARCA" Type="Int32" />
        </UpdateParameters>
        

    </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSourceComp" runat="server" ConnectionString="<%$ ConnectionStrings:CrisTimeConnection %>" SelectCommand="SELECT [IdCOMPANIE], [NUME] FROM [COMPANII]"></asp:SqlDataSource>


</asp:Content>
