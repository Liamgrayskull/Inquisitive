BlockEvents.rightClicked((event) => {
  if (event.item.is("flint")) {
    JsonIO.write("kubejs/inventory.json", {
      items: event.block.inventory.allItems.map((item) => item.id),
    });
    event.cancel();
  }
});