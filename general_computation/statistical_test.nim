# statistical_tests.nim

import sequtils, math

proc tTest(sample1: seq[float], sample2: seq[float]): float =
  let mean1 = sample1.mean()
  let mean2 = sample2.mean()
  
  let var1 = sample1.var()
  let var2 = sample2.var()
  
  let n1 = sample1.len()
  let n2 = sample2.len()
  
  let pooledVar = ((n1 - 1) * var1 + (n2 - 1) * var2) / (n1 + n2 - 2)
  
  let tStat = (mean1 - mean2) / sqrt(pooledVar * (1.0/n1 + 1.0/n2))
  
  return tStat

proc anova(samples: seq[seq[float]]): float =
  let overallMean = samples.flatMap(identity).mean()
  
  let ssTotal = samples.flatMap(identity).map(x => (x - overallMean) ** 2).sum()
  
  var ssBetween = 0.0
  for sample in samples:
    let meanSample = sample.mean()
    ssBetween += sample.len() * ((meanSample - overallMean) ** 2)

  return ssBetween / ssTotal

# Example usage:
let groupA = @[10.0, 20.0, 30.0]
let groupB = @[15.0, 25.0, 35.0]

let tStat = tTest(groupA, groupB)
echo "T-Test Statistic: ", tStat

let anovaStat = anova(@[groupA, groupB])
echo "ANOVA Statistic: ", anovaStat
