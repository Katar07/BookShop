page 50361 "Cart Card"
{
    ApplicationArea = All;
    Caption = 'Cart Card';
    PageType = Document;
    SourceTable = Cart;
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
                field(Default; Rec.Default)
                {
                    ToolTip = 'Specifies the value of the Default field.';
                }
                field("TotalQuantity"; Rec.TotalQuantity)
                {
                    ToolTip = 'Specifies the value of the Total Quantity field.';
                }
                field("TotalAmount"; Rec.TotalAmount)
                {
                    ToolTip = 'Specifies the value of the Total Amount field.';
                }
                field("BackendCustomerId"; Rec."BackendCustomer No.")
                {
                    ToolTip = 'Specifies the value of the Total Amount with discount field.';
                    Visible = false;
                }
                field("BackendSalesInvoice"; Rec."Backend Sales Invoice No")
                {
                    ToolTip = 'Specifies the value of the Total Amount with discount field.';
                    Visible = false;
                }


            }
            part(Lines; "Cart Line")
            {
                SubPageLink = "Cart No." = field("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action(CreateInvoice)
            {
                ApplicationArea = All;
                Caption = 'Buy';
                Image = Payment;
                ToolTip = 'Executes the Create Invoice action.';
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                RunObject = codeunit "Create Invoice";
            }
        }
    }

    trigger OnAfterGetRecord()
    var
    begin
        Rec.TotalQuantity := Rec.TotalCartQuantity();
        Rec.TotalAmount := Rec.TotalCartAmount();
    end;

    trigger OnDeleteRecord(): Boolean
    var
        CreateInvoiceCodeunit: Codeunit "Create Invoice";
    begin
        CreateInvoiceCodeunit.DeleteCartLines(Rec);
    end;
}
