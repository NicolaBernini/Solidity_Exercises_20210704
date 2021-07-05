
# Overview 

In the Flash Loans use case, there are essentially 2 actors: a lender and a receiver 

The lender exposes a function allowing the receiver to 
- borrow some tokens and 
- gets called to a specific callback function 

This way the receiver can do whatever it wants within that callback function and eventually when this function returns and the control goes back to the lender, the lender can make the appropriate checks to verify the borrowed tokens have been returned and the fees are paid 





















