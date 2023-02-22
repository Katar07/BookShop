page 50372 "Item Rent Cart FactBox"
{
    ApplicationArea = All;
    Caption = 'Books For Rent';
    PageType = ListPart;
    SourceTable = "Rent Cart Line";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Item No."; Rec."Item No.")
                {
                    Visible = false;
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Description"; Rec."Description")
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the value of the Quantity field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(RentBook)
            {
                Caption = 'Rent Books in Cart';
                ApplicationArea = All;
                ToolTip = 'Executes the Rent Book action.';
                Image = CarryOutActionMessage;


                trigger OnAction()
                var
                    RentCart: Record "Rent Cart";
                    LoginManagement: Codeunit "User Login Management";
                    EmptyCartErr: Label 'Your cart is empty';
                begin
                    RentCart.SetRange("User Name", LoginManagement.GetCurrentUserLogin()."User Name");
                    if Rec.IsEmpty() then
                        Error(EmptyCartErr);
                    Rec.TestField("Rent Cart No.");
                    RentCart.Get(Rec."Rent Cart No.");

                    Page.Run(Page::"Rent Card", RentCart);
                end;
            }


            action(MyCarts)
            {
                Caption = 'Go to my Rent Cart';
                ApplicationArea = All;
                ToolTip = 'Executes the my Rent Cart action.';
                Image = OpenJournal;

                trigger OnAction()
                var
                    RentCart: Record "Rent Cart";
                begin
                    Page.Run(Page::"Rent Cart List", RentCart);
                end;
            }

        }
    }


}
