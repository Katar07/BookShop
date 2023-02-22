table 50363 "Return Cart"
{
    Caption = 'Return Cart';
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
        field(4; "User Name"; Text[100])
        {
            DataClassification = EndUserIdentifiableInformation;
            Editable = false;
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

        }
        field(9; TotalQuantity; Decimal)
        {
            Caption = 'Total Quantity';
            Editable = false;
        }
        field(10; TotalAmount; Decimal)
        {
            Caption = 'Total Cart Amount';
            Editable = false;
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
        ReturnCart: Record "Return Cart";
        UserLoginManagement: Codeunit "User Login Management";
    begin
        Rec."User Name" := UserLoginManagement.GetCurrentUserLogin()."User Name";
        Rec."Customer No" := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
        Rec.Description := 'My cart';

        ReturnCart.SetRange("User Name", UserLoginManagement.GetCurrentUserLogin()."User Name");
        ReturnCart.SetFilter("No.", '<>%1', Rec."No.");
        if ReturnCart.IsEmpty() then
            Rec.Default := true;
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
        ReturnCartLine: Record "Return Cart Line";
    begin
        ReturnCartLine.SetRange(ReturnCartLine."Return Cart No.", "No.");
        ReturnCartLine.SetRange(ReturnCartLine."Return Line No.");
        if ReturnCartLine.FindSet() then
            repeat
                TotalQt += ReturnCartLine.Quantity;

            until ReturnCartLine.Next() = 0;
        exit(TotalQt);
    end;

    procedure TotalCartAmount() TotalAm: Decimal
    var
        ReturnCartLine: Record "Return Cart Line";
    begin
        ReturnCartLine.SetRange(ReturnCartLine."Return Cart No.", "No.");
        ReturnCartLine.SetRange(ReturnCartLine."Return Line No.");
        if ReturnCartLine.FindSet() then
            repeat
                TotalAm += ReturnCartLine.Amount;

            until ReturnCartLine.Next() = 0;
        exit(TotalAm);
    end;

}
