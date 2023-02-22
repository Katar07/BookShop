page 50378 "VisualCardPart"
{
    ApplicationArea = All;
    Caption = 'Visual Navigate';
    PageType = CardPart;
    SourceTable = "VisualTableSetup";

    layout
    {
        area(content)
        {
            grid(Grid1)
            {
                ShowCaption = false;
                group(G1)
                {
                    ShowCaption = false;
                    field(Media1; Rec.Media1)
                    {
                        ToolTip = 'Specifies the value of the Media field.';
                    }
                    field(TextNavigate; 'Buy Book')
                    {
                        ApplicationArea = all;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            Page.Run(Page::"Item List");
                        end;
                    }
                }
                group(G2)
                {
                    ShowCaption = false;
                    field(Blob; Rec.Media4)
                    {
                        ToolTip = 'Specifies the value of the Media field.';
                    }
                    field(TextNavigate1b; 'Rent Book')
                    {
                        ApplicationArea = all;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            Page.Run(Page::"Item List");
                        end;
                    }
                }
                group(G3)
                {
                    ShowCaption = false;
                    field(Media6; Rec.Media6)
                    {
                        ToolTip = 'Specifies the value of the Media field.';
                    }
                    field(TextNavigate1c; 'Return Book')
                    {
                        ApplicationArea = all;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            Page.Run(Page::"Return Cart List");
                        end;
                    }
                }
                group(G4)
                {
                    ShowCaption = false;
                    field(Media2; Rec.Media2)
                    {
                        ToolTip = 'Specifies the value of the Media field.';
                    }
                    field(TextNavigate2; 'My Carts')
                    {
                        ApplicationArea = all;
                        ShowCaption = false;

                        trigger OnDrillDown()
                        begin
                            Page.Run(Page::"Cart List");
                        end;
                    }
                }
                group(G5)
                {
                    ShowCaption = false;
                    field(Media3; Rec.Media3)
                    {

                        ToolTip = 'Specifies the value of the Media field.';
                    }
                    field(TextNavigate3; 'Order History')
                    {
                        ApplicationArea = all;
                        ShowCaption = false;


                        trigger OnDrillDown()
                        begin
                            Page.Run(Page::"Posted Sales Invoices");
                        end;
                    }
                }

                group(G6)
                {
                    ShowCaption = false;
                    field(Media4; Rec.Media5)
                    {

                        ToolTip = 'Specifies the value of the Media field.';
                    }
                    field(TextNavigate4; 'Return Rent Books History')
                    {
                        ApplicationArea = all;
                        ShowCaption = false;


                        trigger OnDrillDown()
                        begin
                            Page.Run(Page::"Posted Sales Credit Memos");
                        end;
                    }
                }

            }
            cuegroup("CueGroup")
            {
                ShowCaption = false;
                field(""; 'Cue')
                {
                    ShowCaption = false;
                    Visible = false;

                }
            }
        }
    }
}