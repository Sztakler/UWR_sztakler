blockHeights = [4, 3, 2, 1]
# blockHeights = [1, 3]
blockHeights = [1, 2, 2, 4, 5, 7]
# blockHeights = [3, 2, 4]
# blockHeights = [12,6,13,14,6,15,9,11,7,7]
# blockHeights = [15,11,10,13,9,5,8,8,14,7]
# blockHeights = [23,32,24,21]
# blockHeights = [3, 4, 5]
# blockHeights = [91,112,104,105,97,92,93,102,109,112,114,116,97,96,100,98,113,111,124,105,96,103,100,104,104,92,100,78,115,94,106,88,79,107,96,107,95,109,85,82,97,103,106,99,93,95,124,96,87,104,104,104,108,110,101,110,104,83,92,75,83,85,98,82,102,96,95,101,111,113,88,99,93,111,106,95,99,113,87,103,91,83,97,110,90,119,106,95,107,103,122,96,98,99,107,93,99,103,110,86]
# blockHeights = [85,95,93,90,114,95,102,104,95,91,110,92,96,110,91,94,107,75,88,94,85,100,112,104,90,100,91,110,94,99,102,90,86,111,115,92,96,86,102,97,90,99,107,94,107,103,102,110,107,92,95,99,111,106,107,104,97,98,106,101,104,121,97,106,104,113,87,87,101,93,105,106,97,94,104,114,105,105,90,94,115,104,96,126,106,115,77,101,93,106,92,114,107,116,105,91,97,107,91,96]
# blockHeights = [1,2,2,4,5,7]
# blockHeights = [204,216,180,214,187,198,193,183,176,192,179,202,184,221,236,208,185,230,203,208,236,205,199,215,211,192,197,199,205,200,212,209,195,177,176,197,208,206,184,193,200,214,182,203,189,202,171,205,190,199,206,202,203,179,212,199,222,205,179,189,193,204,203,213,198,192,201,226,188,211,213,210,217,185,186,190,204,211,198,178,208,189,203,200,176,190,205,177,215,209,210,207,196,235,186,204,230,188,216,190,178,191,207,213,206,220,198,204,214,234,202,177,210,208,182,193,181,202,185,209,202,192,200,172,191,186,199,208,209,194,200,202,206,219,213,187,168,215,212,178,195,171,195,231,222,181,182,192,196,177,209,200,205,187,182,179,208,197,204,202,201,206,206,180,212,192,203,179,190,194,197,220,199,180,216,204,208,184,206,216,200,202,205,221,202,190,208,213,197,178,194,188,223,199,178,196,210,178,206,198,217,187,229,207,196,195,201,198,207,206,192,211,216,200,182,216,201,194,210,226,215,173,186,187,212,190,193,209,204,213,216,198,224,181,204,214,209,197,189,209,204,200,206,215,176,207,198,207,214,215,210,171,193,198,220,214,194,212,196,173,198,202,221,195,209,207,215,194,201,204,216,205,197,210,198,214,194,214,192,214,208,184,196,190,190,186,199,187,193,176,208,205,217,212,209,196,213,219,208,205,203,202,195,196,193,178,183,223,216,183,199,217,209,194,199,191,208,186,201,205,193,171,186,187,175,207,199,202,204,210,201,207,190,168,220,180,203,214,199,228,198,204,228,216,190,194,197,205,219,220,213,198,205,199,202,173,185,201,207,200,182,202,208,221,181,203,182,213,229,206,192,215,195,180,185,187,224,193,199,189,205,209,196,211,173,210,196,212,182,223,199,224,222,201,194,188,183,181,213,199,195,227,203,217,216,204,191,206,213,209,198,193,186,201,166,199,188,205,174,187,217,215,179,206,211,184,195,192,200,199,189,187,203,191,190,230,188,214,215,229,206,188,200,200,193,179,186,205,200,211,203,178,205,214,181,173,217,211,216,205,227,193,194,214,182,172,195,202,177,194,198,211,183,199,176,217,182,212,203,207,205,195,220,195,185,203,200,183,208,191,210,196,201,212,167,199,207,204,197,195]
blockHeights = [1, 2]
blockHeights.sort()

n = len(blockHeights)
maxDifference = sum(blockHeights) + 1

# maxHeights = [[0]*maxDifference]*n
maxHeights = [[0 for i in range(maxDifference)] for j in range(n)]


# print("maxHeights = ", maxHeights)

def calculateNewHeight(blockHeight, newDifference, oldDifference, oldMaxHeight):
    # if blockHeight > newDifference:
    #     return oldMaxHeight - oldDifference + blockHeight
    # return  oldMaxHeight + blockHeight

    smallerHeight = oldMaxHeight - oldDifference
    # print(smallerHeight, oldMaxHeight, oldDifference, newDifference)
    if smallerHeight < 0: return 0

    if abs(smallerHeight + blockHeight - oldMaxHeight) == newDifference:
        return max(smallerHeight + blockHeight, oldMaxHeight)
    elif oldMaxHeight + blockHeight - smallerHeight == newDifference:
        return oldMaxHeight + blockHeight
    return 0


def getMaxHeight(newDifference, blockHeight, maxHeights, i):
    oldDifference = abs(blockHeight - newDifference)
    oldMaxHeight = maxHeights[i-1][oldDifference]
    newMaxHeight = calculateNewHeight(blockHeight, newDifference, oldDifference, oldMaxHeight)
    # print(oldDifference, oldMaxHeight, newMaxHeight)
    return newMaxHeight

# print(maxHeights[0][blockHeights[0]])
# print(blockHeights)
maxHeights[0][blockHeights[0]] = blockHeights[0]
# print(maxHeights[0][blockHeights[0]])
# print(maxHeights)

maxHeightMinDiffPair = (0, maxDifference)

def minimum(currentMin, newMin):
    if newMin[0] >= currentMin[0] and newMin[1] <= currentMin[1]:
        return newMin
    return currentMin

for i in range(1, n):
    for difference in range(maxDifference):
        newDifference = difference
        blockHeight = blockHeights[i]

        oldDifference1 = abs(blockHeight - newDifference)   
        oldDifference2 = blockHeight + newDifference 

        oldMaxHeight1 = maxHeights[i-1][oldDifference1]
        if oldDifference2 < maxDifference: 
            oldMaxHeight2 = maxHeights[i-1][oldDifference2]
        
        newMaxHeight1 = calculateNewHeight(blockHeight, newDifference, oldDifference1, oldMaxHeight1)
        newMaxHeight2 = calculateNewHeight(blockHeight, newDifference, oldDifference2, oldMaxHeight2)
        newMaxHeight3 = maxHeights[i-1][newDifference]
        newMaxHeight = max(newMaxHeight1, newMaxHeight2, newMaxHeight3)
        # print(oldDifference, oldMaxHeight, newMaxHeight)

        # maxHeights[i][difference] = getMaxHeight(newDifference, blockHeights[i], maxHeights, i)
        maxHeights[i][difference] = newMaxHeight  
        maxHeightMinDiffPair = minimum(maxHeightMinDiffPair, (newMaxHeight, difference))
        # print(maxHeights)

def printColumn(array, k):
    for i in range(len(array)):
        print(array[i][k], end=", ")
    print()

if maxHeightMinDiffPair[1] == 0 and maxHeightMinDiffPair[0] != 0:
    print("TAK")
    print(maxHeightMinDiffPair[0])
    print(maxHeightMinDiffPair)
else:
    print("NIE")
    print(maxHeightMinDiffPair[1])
    print(maxHeightMinDiffPair)
# printColumn(maxHeights, 0)
# printColumn(maxHeights, 1)