pageextension 50351 "Item Book List" extends "Item List"
{


    layout
    {

        modify(ItemAttributesFactBox)
        {
            Visible = false;
        }
        modify(Control1906840407)
        {
            Visible = false;
        }
        modify(Control1901314507)
        {
            Visible = false;
        }



        addfirst(factboxes)
        {

            part(BookPart; "Item Book Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = FIELD("No.");
            }

            part(CartPart; "Item Cart FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "Cart No." = field("Cart Filter");
            }
            part(ItemRent; "Item Rent Cart FactBox")
            {
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        modify(AdjustInventory)
        {
            Visible = false;
        }
        modify(CopyItem)
        {
            Visible = false;
        }
        addafter(CopyItem)
        {
            action(AddToCart)
            {
                Caption = 'Buy Selected Book';
                ApplicationArea = All;
                ToolTip = 'Executes the Buy Book action.';
                Image = Add;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    Cart: Record Cart;
                    AddToCart: Codeunit "Add to Card";
                    UserLoginManagement: Codeunit "User Login Management";
                    NoUserErrLbl: Label 'Please Sign In before add items in cart!';
                    CustomerNo: Code[20];
                begin
                    CustomerNo := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
                    if CustomerNo <> '' then begin
                        AddToCart.Run(Rec);
                        Cart.FindMyDefault();
                    end
                    else
                        Error(NoUserErrLbl);
                end;
            }
            action(RentBook)
            {
                Caption = 'Rent Selected Book';
                ApplicationArea = All;
                ToolTip = 'Executes the Rent Book action.';
                Image = ShipAddress;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;

                trigger OnAction()
                var
                    RentCart: Record "Return Cart";
                    RentBook: Codeunit "AddRent Book";
                    UserLoginManagement: Codeunit "User Login Management";
                    NoUserErrLbl: Label 'Please Sign In before add items in cart!';
                    CustomerNo: Code[20];
                begin
                    CustomerNo := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
                    if CustomerNo <> '' then begin
                        RentBook.Run(Rec);
                        RentCart.FindMyDefault();
                    end
                    else
                        Error(NoUserErrLbl);
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        Cart: Record Cart;
    begin
        if Cart.FindMyDefault() then
            Rec.SetRange("Cart Filter", Cart."No.")
        else
            Rec.SetRange("Cart Filter", '');
        Rec.SetFilter("Item Category Code", 'BOOKS');
    end;
}



// Prikaz selektiranog Item-a CurrPage.SetSelectionFilter(SelectedItem);
// Ako se izabere više Message ('No. of selected items is: %', SelectedItemCount())
