page 50373 "Rent Card"
{
    ApplicationArea = All;
    Caption = 'Rent Card';
    PageType = Document;
    SourceTable = "Rent Cart";
    RefreshOnActivate = true;
    UsageCategory = Documents;


    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Description field.';
                }
                field("User Name"; Rec."User Name")
                {
                    ToolTip = 'Specifies the value of the User Name field.';
                }

                field("Customer No"; Rec."Customer No")
                {

                    ToolTip = 'Specifies the value of the Default field.';
                    Visible = false;
                }

                field("TotalQuantity"; Rec.TotalQuantity)
                {
                    ToolTip = 'Specifies the value of the Total Quantity field.';
                }
            }
            part(Lines; "Rent Cart Line")
            {
                SubPageLink = "Rent Cart No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Rent)
            {
                ApplicationArea = All;
                Caption = 'Rent Books in Cart';
                Image = Payment;
                ToolTip = 'Executes the Rent action.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = codeunit "Create Rent Invoice";
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        Rec.TotalQuantity := Rec.TotalCartQuantity();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        CreateRentInvoice: Codeunit "Create Rent Invoice";
    begin
        CreateRentInvoice.DeleteCartLines(Rec);
    end;



}
