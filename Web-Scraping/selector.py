# Function to calculate Profit.
def Profit(costPrice, sellingPrice) :

    profit = (sellingPrice - costPrice)

    return profit

# Function to calculate Loss.
def Loss(costPrice, sellingPrice) :

    Loss = (costPrice - sellingPrice)

    return Loss

# Driver code
if __name__ == "__main__" :

    costPrice, sellingPrice = 1500, 2000

    if sellingPrice == costPrice :
        print("No profit nor Loss")

    elif sellingPrice > costPrice :
        print(Profit(costPrice, 
                     sellingPrice), "Profit")

    else :
        print(Loss(costPrice, 
                   sellingPrice), "Loss")