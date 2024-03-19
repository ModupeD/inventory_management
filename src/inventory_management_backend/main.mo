import HashMap "mo:base/HashMap";
import Text "mo:base/Text";
import Iter "mo:base/Iter";
actor {

  type InventoryItem = {
    name : Text;
    quantity : Nat;
    price : Nat;
    description : Text;
  };

  var inventory = HashMap.HashMap<Text, InventoryItem>(0, Text.equal, Text.hash);

  public query func listInventory() : async [InventoryItem] {
    return Iter.toArray(inventory.vals());
  };

  public shared func addNewItem(item : InventoryItem) {
    inventory.put(item.name, item);
  };

  public shared func updateStock(itemName : Text, quantity : Nat) {
    var item = inventory.get(itemName);

    switch (item) {
      case (?value) {
        var updatedItem = {
          name = value.name;
          quantity = quantity;
          price = value.price;
          description = value.description;
        };

        inventory.put(itemName, updatedItem);
      };
      case (null) {};
    };
  };

  public shared func deleteItem(itemName : Text) {
    inventory.delete(itemName);
  };

};
