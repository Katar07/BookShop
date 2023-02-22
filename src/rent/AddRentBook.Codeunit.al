codeunit 50357 "AddRent Book"
{
    TableNo = Item;

    trigger OnRun()
    var
        RentCartNo: Code[20];
    begin
        RentCartNo := SelectCart();
        if not AddCartLine(RentCartNo, Rec) then
            CreateCartLine(RentCartNo, Rec);
    end;

    local procedure SelectCart(): Code[20]
    var
        RentCart: Record "Rent Cart";
        UserLoginManagement: Codeunit "User Login Management";
        CustomerNo: Code[20];
    begin
        CustomerNo := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
        if not RentCart.FindMyDefault() then begin
            RentCart.Init();
            RentCart."No." := RentCart.CreateNewNo();
            RentCart.Description := 'My cart';
            RentCart."Customer No" := CustomerNo;
            RentCart.Insert(true);
        end;
        exit(RentCart."No.");
    end;

    local procedure CreateCartLine(RentCartNo: Code[20]; Item: Record Item)
    var
        RentCartLine: Record "Rent Cart Line";
    begin
        RentCartLine.Init();
        RentCartLine."Rent Cart No." := RentCartNo;
        RentCartLine."Rent Line No." := GetLastCartLineNo(RentCartNo) + 10000;
        RentCartLine.Validate("Item No.", Item."No.");
        RentCartLine.Validate(Quantity, 1);
        RentCartLine.Insert(true);
    end;


    local procedure GetLastCartLineNo(RentCartNo: Code[20]): Integer
    var
        RentCartLine: Record "Rent Cart Line";
    begin
        RentCartLine.SetRange("Rent Cart No.", RentCartNo);
        if RentCartLine.FindLast() then
            exit(RentCartLine."Rent Line No.")
    end;

    local procedure AddCartLine(RentCartNo: Code[20]; Item: Record Item) Found: Boolean
    var
        RentCartLine: Record "Rent Cart Line";
    begin
        RentCartLine.SetRange("Rent Cart No.", RentCartNo);
        RentCartLine.SetRange("Item No.", Item."No.");
        Found := RentCartLine.FindFirst();
        if Found then begin
            RentCartLine.Validate(Quantity, RentCartLine.Quantity + 1);
            RentCartLine.Modify(true);
        end;
    end;



}