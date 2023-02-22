page 50363 "Cart List"
{
    ApplicationArea = All;
    Caption = 'Cart List';
    PageType = List;
    Editable = false;
    SourceTable = Cart;
    UsageCategory = Lists;
    CardPageId = "Cart Card";
    RefreshOnActivate = true;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action("My Rent Cart")
            {
                ApplicationArea = All;
                Caption = 'My Rent Cart';
                Image = Shipment;
                ToolTip = 'Executes the My Rent Cart action.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = page "Rent Cart List";

            }
        }

    }

    trigger OnOpenPage()
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec.SetRange("Customer No", UserLoginManagement.GetCurrentUserLogin()."Customer No.");
    end;

}
