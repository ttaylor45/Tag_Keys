# Tag_Keys

TAG Keys is a Winnipeg based business that sells digital PC game keys. The company has
evolved from being just a game catalog website, to a game store. The business has been
running for 4 years prior to the switch and is currently having 10 employees. These are
customer support representatives, inventory managers, digital content administrators, and
management.

The company will sell digital game keys for the popular PC game platform Steam. This also
includes downloadable content like (DLC) expansion packs, game bundles, and maybe gift
cards.

Currently, TAG Keys sells its product through its physical retail store down by Regent Ave at the
corner of a strip mall. The customers would buy physical copies of the games from the local of
Winnipeg, but TAG keys have plans for world-wide distribution. The goal we have as a company
is to have Ruby on Rails e-commerce website to automate this process by allowing world-wide
customers to browse the products, purchase digital game keys securely, and instantly received
their purchased copy of any game key through their online account.

The primary target is gamers between the ages of 16 and 45 years old, who purchases digital
games for PC mainly for Steam. This website will tailor towards the casual gamers, some
competitive players, students, and workers who prefer to pay over online copies instead of
driving to our physical location in Regent.

I understand that world-wide distribution is ambiguous, so instead we will be creating a
prototype for Canada. The online store will be focusing on providing fast, easy-to-use shopping
experience with products, organized categories, secured customer accounts and in-returned
immediate access to purchased digital game keys.

Below is a ERD Diagram that shows the database we will be implementing for the project.
The example below is a legend on how to read the rest.

# Table Title
• Description of the tables
o Associations with tables.
ERD Diagram description details below.

# Users
• Stores the information for both the customers and admins.
o Users can have one to many orders.
o Users will have one cart.

# Orders
• The Orders tables store how many orders the customer has and the amounts.
o Orders can have one to many order_items.

# Order_Items
• This stores how many games there is and the price amounts.
o Each order_item is linked to one game key.

# Cart
• Stores active carts for users
o One cart can have many cart_items

# Cart_Items
• Stores the number of games and quantities added to the cart

# Games
• Stores game details and the price, stock on the game.
o One game can be in many cart_items.
o One game can be in many order_items.
o One game can have many games keys

# Game_Keys
• Stores the unique digital game keys that can be sold.

# Catorgories
• Stores game categories to organize game products.
o One category can have many games.

# Payments
• Stores payment details for orders.
o One payment belongs to one order.