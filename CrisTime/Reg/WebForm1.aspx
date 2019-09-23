<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="CrisTime.Reg.WebForm1" %>




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


    <br />

    <asp:Literal ID="Literal1" runat="server"></asp:Literal>
    <br />

    


    <table class="hide-on-print">
        <tr>
            <td>LUNA</td>
            <td>AN</td>
            <td>Nume </td>
            <td>firma</td>
        </tr>
        <tr>
            <td>
                <asp:DropDownList ID="DropDownListLuna" runat="server" DataSourceID="SqlDataSourceLuna" DataTextField="Column1" DataValueField="Column1" AutoPostBack="True" CssClass="working"></asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList
                    ID="DropDownListan"
                    runat="server"
                    AutoPostBack="True" DataSourceID="SqlDataSourceAN" DataTextField="Column1" DataValueField="Column1" CssClass="working">
                    <asp:ListItem Selected="True">an</asp:ListItem>

                </asp:DropDownList>

            </td>
            <td>
                <asp:DropDownList ID="DropDownListMarca" runat="server" AutoPostBack="True" DataSourceID="SqlDataSourceNume" DataTextField="Column2" DataValueField="Column1" CssClass="working"></asp:DropDownList>
            </td>
            <td>
                <asp:DropDownList ID="DropDownfirma" runat="server" DataSourceID="SqlDataSourcefirma" DataTextField="NUME" DataValueField="IdCOMPANIE" AutoPostBack="true" CssClass="working"></asp:DropDownList>

            </td>
        </tr>
    </table>
    <div style="float: left" class="hide-on-print">
        <asp:Button ID="ButtonCalc11" runat="server" Text="Recalculeaza" OnClick="ButtonCalc_Click" CssClass="working_btn" />
    </div>
    <div style="float: right" class="hide-on-print">
    <asp:Button ID="Button2" runat="server" Text="Salveaza " OnCommand="Button2_Command" CssClass="working_btn" OnClick="Button2_Click"/>
        </div>
    <br />
    <hr class="hide-on-print" />
    <asp:Panel ID="Panel1" runat="server">


        <br />
        <h2 style="text-align: left">
            <asp:Literal ID="LiteralFirma" runat="server" Text=""></asp:Literal>
        </h2>
        <div class="hide-on-print" style="float:right;border-width:thin">
            CO = Concediu Odihna;
            <br />
            CFS = Concediu fara salar , Invoiri;
            <br />
            CM = Concediu Medical;
            <br />
            EV = Evenimente Speciale ( Nunta, deces in familie, nastere copii ...)
            <br /> 
            N = Nemotivat;
        
        </div>
        <br />
        <br />
            &nbsp;<h2 style="text-align: center">Pontaj
                        <asp:Literal ID="LiteralLuna" runat="server"></asp:Literal>
            <asp:Literal ID="LiteralAn" runat="server"></asp:Literal>
        </h2>
        <br />

        <asp:GridView ID="GridViewPontaj" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSourcepontaj" OnRowDataBound="GridViewPontaj_RowDataBound" ValidateRequestMode="Disabled" ViewStateMode="Inherit" DataKeyNames="luna,an" BorderStyle="Solid" SortedAscendingHeaderStyle-Wrap="False" BorderWidth="2px">
             <Columns>
                <asp:BoundField DataField="MARCA" HeaderText="MARCA" ItemStyle-BackColor="Cornsilk" SortExpression="MARCA" ItemStyle-VerticalAlign="Top" ControlStyle-CssClass="hidden" FooterStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                    <ItemStyle BackColor="Cornsilk" />
                </asp:BoundField>
                <%--<asp:BoundField DataField="NUME" HeaderText="NUME" ItemStyle-BackColor="Cornsilk" SortExpression="NUME" ItemStyle-VerticalAlign="Top" ItemStyle-Width="40px" InsertVisible="True" HeaderStyle-Width="40px" FooterStyle-Width="40px" ControlStyle-Width="40px">
                
                    <ItemStyle BackColor="Cornsilk" />
                </asp:BoundField>
                --%>
                 <asp:TemplateField HeaderText="NUME" SortExpression="NUME"   ItemStyle-BackColor="Cornsilk"  >
                     <ItemTemplate>
                         <div class="PontajNume" style="/*width:90px;*/ height:auto; overflow:hidden; word-break:break-word;">
                             <asp:Literal ID="nume" runat="server" Text='<%# Bind("NUME") %>' ></asp:Literal>
                         </div>

                     </ItemTemplate>
                 </asp:TemplateField>
                
                <asp:BoundField DataField="luna" HeaderText="luna" ItemStyle-BackColor="Cornsilk" SortExpression="luna" ItemStyle-VerticalAlign="Top" ItemStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" FooterStyle-CssClass="hidden" ControlStyle-CssClass="hidden">
                    <ItemStyle BackColor="Cornsilk" />
                </asp:BoundField>
                <asp:BoundField DataField="an" HeaderText="an" ItemStyle-BackColor="Cornsilk" SortExpression="an" ItemStyle-VerticalAlign="Top" InsertVisible="True" ControlStyle-CssClass="hidden" FooterStyle-CssClass="hidden" HeaderStyle-CssClass="hidden" ItemStyle-CssClass="hidden">
                    <ItemStyle BackColor="Cornsilk" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="1" SortExpression="1">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox1" runat="server" BorderStyle="NotSet" CssClass="tt" Text='<%# Bind("1") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica1" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v1" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p1" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                       <div class="abs" id="div1">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal1" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="2" SortExpression="2">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox2" runat="server" CssClass="tt" Text='<%# Bind("2") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica2" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                        <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v2" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p2" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                    
                        <div class="abs" id="div2">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal2" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="3" SortExpression="3">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox3" runat="server" CssClass="tt" Text='<%# Bind("3") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica3" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v3" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p3" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div3">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal3" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="4" SortExpression="4">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox4" runat="server" CssClass="tt" Text='<%# Bind("4") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica4" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v4" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p4" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div4">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal4" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="5" SortExpression="5">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox5" runat="server" CssClass="tt" Text='<%# Bind("5") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica5" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v5" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p5" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div5">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal5" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="6" SortExpression="6">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox6" runat="server" CssClass="tt" Text='<%# Bind("6") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica6" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v6" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p6" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div6">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal6" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="7" SortExpression="7">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox7" runat="server" CssClass="tt" Text='<%# Bind("7") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica7" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v7" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p7" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div7">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal7" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="8" SortExpression="8">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox8" runat="server" CssClass="tt" Text='<%# Bind("8") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica8" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v8" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p8" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div8">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal8" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="9" SortExpression="9">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox9" runat="server" CssClass="tt" Text='<%# Bind("9") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica9" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v9" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p9" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div9">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal9" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="10" SortExpression="10">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox10" runat="server" CssClass="tt" Text='<%# Bind("10") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica10" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v10" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p10" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div10">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal10" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="11" SortExpression="11">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox11" runat="server" CssClass="tt" Text='<%# Bind("11") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica11" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v11" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p11" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div11">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal11" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="12" SortExpression="12">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox12" runat="server" CssClass="tt" Text='<%# Bind("12") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica12" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v12" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p12" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div12">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal12" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="13" SortExpression="13">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox13" runat="server" CssClass="tt" Text='<%# Bind("13") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica13" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v13" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p13" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>                        </asp:Table>
                        <div class="abs" id="div13">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal13" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="14" SortExpression="14">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox14" runat="server" CssClass="tt" Text='<%# Bind("14") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica14" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v14" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p14" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>                        </asp:Table>
                        <div class="abs" id="div14">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal14" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="15" SortExpression="15">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox15" runat="server" CssClass="tt" Text='<%# Bind("15") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica15" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v15" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p15" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div15">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal15" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="16" SortExpression="16">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox16" runat="server" CssClass="tt" Text='<%# Bind("16") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica16" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v16" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p16" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>                        </asp:Table>
                        <div class="abs" id="div16">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal16" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="17" SortExpression="17">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox17" runat="server" CssClass="tt" Text='<%# Bind("17") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica17" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v17" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p17" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div17">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal17" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="18" SortExpression="18">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox18" runat="server" CssClass="tt" Text='<%# Bind("18") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica18" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v18" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p18" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div18">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal18" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="19" SortExpression="19">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox19" runat="server" CssClass="tt" Text='<%# Bind("19") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica19" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v19" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p19" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div19">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal19" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="20" SortExpression="20">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox20" runat="server" CssClass="tt" Text='<%# Bind("20") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica20" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v20" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p20" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div20">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal20" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="21" SortExpression="21">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox21" runat="server" CssClass="tt" Text='<%# Bind("21") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica21" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v21" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p21" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div21">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal21" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="22" SortExpression="22">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox22" runat="server" CssClass="tt" Text='<%# Bind("22") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica22" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v22" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p22" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>                        </asp:Table>
                        <div class="abs" id="div22">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal22" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="23" SortExpression="23">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox23" runat="server" CssClass="tt" Text='<%# Bind("23") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica23" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v23" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p23" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div23">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal23" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="24" SortExpression="24">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox24" runat="server" CssClass="tt" Text='<%# Bind("24") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica24" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v24" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p24" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div24">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal24" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="25" SortExpression="25">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox25" runat="server" CssClass="tt" Text='<%# Bind("25") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica25" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v25" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p25" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div25">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal25" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="26" SortExpression="26">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox26" runat="server" CssClass="tt" Text='<%# Bind("26") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica26" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v26" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p26" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div26">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal26" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="27" SortExpression="27">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox27" runat="server" CssClass="tt" Text='<%# Bind("27") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica27" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v27" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p27" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div27">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal27" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="28" SortExpression="28">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox28" runat="server" CssClass="tt" Text='<%# Bind("28") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica28" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v28" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p28" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div28">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal28" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="29" SortExpression="29">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox29" runat="server" CssClass="tt" Text='<%# Bind("29") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica29" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v29" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p29" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div29">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal29" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="30" SortExpression="30">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox30" runat="server" CssClass="tt" Text='<%# Bind("30") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica30" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v30" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p30" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div30">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal30" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="31" SortExpression="31">
                    <ItemTemplate>
                        &nbsp;
                        <asp:TextBox ID="TextBox31" runat="server" CssClass="tt" Text='<%# Bind("31") %>' Width="20px"></asp:TextBox>
                        <asp:Table ID="condica31" runat="server" BorderStyle="NotSet" Font-Overline="False" Font-Size="14px" Font-Names="Arial Narrow" CssClass="Pcndc">
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">v:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_v31" BorderStyle="NotSet" Text="  :  "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                           </asp:TableRow>
                            <asp:TableRow>
                                <asp:TableCell runat="server" Width="29%">p:</asp:TableCell>
                                <asp:TableCell runat="server" Width="71%">
                                    <asp:TextBox ID="TextBox_p31" BorderStyle="NotSet" Text=" : "  Width="20px" runat="server" Font-Size="X-Small"></asp:TextBox>
                                </asp:TableCell>
                            </asp:TableRow>
                        </asp:Table>
                        <div class="abs" id="div31">
                            Jurnal Scanari
                            <br />
                            <br />
                            <asp:Table ID="TableJurnal31" runat="server" CssClass="TableJurnalScanari" CellSpacing="0">
                                <asp:TableRow runat="server">
                                    <asp:TableCell runat="server" Width="75px">nume</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">data</asp:TableCell>
                                    <asp:TableCell runat="server" Width="75px">ora</asp:TableCell>
                                    <asp:TableCell runat="server" Width="20px">tip</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                        </div>
                    </ItemTemplate>
                    <HeaderStyle HorizontalAlign="Center" Width="20px" />
                    <ItemStyle HorizontalAlign="Center" />
                </asp:TemplateField>
                <asp:BoundField HeaderStyle-HorizontalAlign="Center" HeaderStyle-Width="40px" HeaderText="Total" ItemStyle-BackColor="LightBlue" ItemStyle-CssClass="Total" ItemStyle-HorizontalAlign="Center">
                    <HeaderStyle HorizontalAlign="Center" Width="40px" />
                    <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                </asp:BoundField>
                <asp:BoundField DataField="FIRMA" HeaderText="FIRMA" SortExpression="FIRMA" Visible="false" />
                <asp:BoundField DataField="comp" HeaderText="comp" SortExpression="comp" Visible="false" />
            </Columns>
            <RowStyle CssClass="rowPontaj" />
        </asp:GridView>


        <br />
        

        <h2 style="text-align: center">Intocmit,
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        Aprobat,
        </h2>
        <br />



    </asp:Panel>
    <asp:Button ID="Expexcel" runat="server" Text="To Excel" OnClick="Expexcel_Click" />
    <br />


</asp:Content>
