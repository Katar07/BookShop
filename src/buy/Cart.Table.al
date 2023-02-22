table 50355 "Cart"
{
    Caption = 'Cart';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
        }
        field(2; Description; Text[50])
        {
            Caption = 'Description';
        }
        field(3; TotalAmount; Decimal)
        {
            Caption = 'Total Cart Amount';
            Editable = false;
        }
        field(4; "User Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
            Caption = 'User Name';
        }
        field(5; Default; Boolean)
        {
            Caption = 'Cart for checkout';
            trigger OnValidate()
            begin
                xRec.TestField(Default, false);
            end;
        }
        field(6; "Customer No"; Code[20])
        {
            Editable = false;
            Caption = 'Customer No';
        }
        field(9; TotalQuantity; Decimal)
        {
            Caption = 'Total Cart Quantity';
            Editable = false;
        }
        field(12; "BackendCustomer No."; Code[20])
        {
            Editable = false;
            Caption = 'BackendCustomer No.';
        }
        field(13; "Backend Sales Invoice No"; Text[100])
        {
            Caption = 'Backend Sales Invoice No';

        }
        field(14; "Posted Sales Invoice No"; Code[20])
        {
            Caption = 'Posted Sales Invoice No';
        }
    }
    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }


    trigger OnInsert()
    var
        Cart: Record Cart;
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec."User Name" := UserLoginManagement.GetCurrentUserLogin()."User Name";
        Rec."Customer No" := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
        Rec.Description := 'My Cart';
        Cart.SetRange("User Name", UserLoginManagement.GetCurrentUserLogin()."User Name");
        Cart.SetFilter("No.", '<>%1', Rec."No.");
        if Cart.IsEmpty() then
            Rec.Default := true;
    end;

    trigger OnModify()
    var
        Cart: Record Cart;
        UserLoginManagement: Codeunit "User Login Management";
    begin
        if (Rec.Default <> xRec.Default) then begin
            Cart.SetRange("User Name", UserLoginManagement.GetCurrentUserLogin()."User Name");
            Cart.SetFilter("No.", '<>%1', Rec."No.");
            Cart.ModifyAll(Default, false, false);
        end;
    end;

    procedure FindMyDefault(): Boolean
    var
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec.SetRange("User Name", UserLoginManagement.GetCurrentUserLogin()."User Name");
        Rec.SetRange(Default, true);
        exit(Rec.FindFirst());
    end;


    procedure TotalCartQuantity() TotalQt: Decimal
    var
        CartLine: Record "Cart Line";
    begin
        CartLine.SetRange(CartLine."Cart No.", "No.");
        CartLine.SetRange(CartLine."Line No.");
        if CartLine.FindSet() then
            repeat
                TotalQt += CartLine.Quantity;

            until CartLine.Next() = 0;
        exit(TotalQt);
    end;

    procedure TotalCartAmount() TotalAm: Decimal
    var
        CartLine: Record "Cart Line";
    begin
        CartLine.SetRange(CartLine."Cart No.", "No.");
        CartLine.SetRange(CartLine."Line No.");
        if CartLine.FindSet() then
            repeat
                TotalAm += CartLine.Amount;

            until CartLine.Next() = 0;
        exit(TotalAm);
    end;


    procedure CreateNewNo(): Code[20]
    var
        Cart: Record "Cart";
    begin
        Cart.LockTable();
        if Cart.FindLast() then
            exit(IncStr(Cart."No."))
        else
            exit('CART-01');
    end;


}
