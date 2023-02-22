page 50364 "Item Cart FactBox"
{
    ApplicationArea = All;
    Caption = 'Items in Cart for Buy';
    PageType = ListPart;
    SourceTable = "Cart Line";
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
            action(CheckOut)
            {
                Caption = 'Check Out';
                ApplicationArea = All;
                ToolTip = 'Executes the Check Out action.';
                Image = CarryOutActionMessage;


                trigger OnAction()
                var
                    Cart: Record Cart;
                    LoginManagement: Codeunit "User Login Management";
                    EmptyCartErr: Label 'Your cart is empty';
                begin
                    Cart.SetRange("User Name", LoginManagement.GetCurrentUserLogin()."User Name");
                    if Rec.IsEmpty() then
                        Error(EmptyCartErr);
                    Rec.TestField("Cart No.");
                    Cart.Get(Rec."Cart No.");

                    Page.Run(Page::"Cart Card", Cart);
                end;
            }
            action(MyCarts)
            {
                Caption = 'Go to my Carts';
                ApplicationArea = All;
                ToolTip = 'Executes the MyCarts action.';
                Image = OpenJournal;

                trigger OnAction()
                begin
                    Page.Run(Page::"Cart List");
                end;
            }

        }
    }

    trigger OnOpenPage()
    var
        Cart: Record Cart;
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Cart.SetRange("Customer No", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
    end;
}
