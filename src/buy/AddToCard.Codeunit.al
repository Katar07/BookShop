
codeunit 50352 "Add to Card"
{
    TableNo = Item;

    trigger OnRun()
    var
        UserLoginManagement: Codeunit "User Login Management";
        CartNo: Code[20];
    begin
        CartNo := SelectCart(UserLoginManagement.GetCurrentUserLogin()."Customer No.");
        if not AddCartLine(CartNo, Rec) then
            CreateCartLine(CartNo, Rec);
    end;

    procedure SelectCart(CustomerNo: Code[20]): Code[20]
    var
        Cart: Record Cart;
        UserLoginManagement: Codeunit "User Login Management";
    begin
        CustomerNo := UserLoginManagement.GetCurrentUserLogin()."Customer No.";
        if not Cart.FindMyDefault() then begin
            Cart.Init();
            Cart."No." := Cart.CreateNewNo();
            Cart.Description := 'My cart';
            Cart.Default := true;
            Cart."Customer No" := CustomerNo;
            Cart.Insert(true);
        end;
        exit(Cart."No.")
    end;

    local procedure CreateCartLine(CartNo: Code[20]; Item: Record Item)
    var
        CartLine: Record "Cart Line";
    begin
        CartLine.Init();
        CartLine."Cart No." := CartNo;
        CartLine."Line No." := GetLastCartLineNo(CartNo) + 10000;
        CartLine.Validate("Item No.", Item."No.");
        CartLine.Validate(Quantity, 1);
        CartLine.Insert(true);
    end;


    local procedure GetLastCartLineNo(CartNo: Code[20]): Integer
    var
        CartLine: Record "Cart Line";
    begin
        CartLine.SetRange("Cart No.", CartNo);
        if CartLine.FindLast() then
            exit(CartLine."Line No.")
    end;

    local procedure AddCartLine(CartNo: Code[20]; Item: Record Item) Found: Boolean
    var
        CartLine: Record "Cart Line";
    begin
        CartLine.SetRange("Cart No.", CartNo);
        CartLine.SetRange("Item No.", Item."No.");
        Found := CartLine.FindFirst();
        if Found then begin
            CartLine.Validate(Quantity, CartLine.Quantity + 1);
            CartLine.Modify(true);
        end;
    end;


}

