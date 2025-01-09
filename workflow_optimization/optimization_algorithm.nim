# optimization_algorithm.nim

import sequtils, random

type
  Individual = object
    resources: seq[int]
    fitness: float

proc calculateFitness(ind: Individual): float =
  # Placeholder fitness function: lower resource usage is better
  return 100.0 / (sum(ind.resources) + 1) # Avoid division by zero

proc mutate(ind: var Individual) =
  let mutationRate = 0.1
  for i in 0 ..< ind.resources.len:
    if random.float() < mutationRate:
      ind.resources[i] = random.randint(1, 100) # Randomly change resource allocation

proc crossover(parent1, parent2: Individual): Individual =
  var child = Individual(resources: @[])
  for i in 0 ..< parent1.resources.len:
    if random.float() < 0.5:
      child.resources.add(parent1.resources[i])
    else:
      child.resources.add(parent2.resources[i])
  child.fitness = calculateFitness(child)
  return child

proc geneticAlgorithm(populationSize: int, generations: int) =
  var population = newSeq[Individual](populationSize)

  # Initialize population with random resources
  for i in 0 ..< populationSize:
    var ind = Individual(resources: newSeq[int](5)) # Assume 5 resource types
    for j in 0 ..< ind.resources.len:
      ind.resources[j] = random.randint(1, 100)
    ind.fitness = calculateFitness(ind)
    population[i] = ind

  for gen in 0 ..< generations:
    population.sortIt((a, b) => a.fitness < b.fitness) # Sort by fitness
    var newPopulation = newSeq[Individual](populationSize)

    # Elitism: carry forward the best individuals
    for i in 0 ..< populationSize div 2:
      newPopulation[i] = population[i]

    # Crossover and mutation to fill the rest of the population
    for i in (populationSize div 2) ..< populationSize:
      let parent1 = population[random.randint(0, populationSize div 2 - 1)]
      let parent2 = population[random.randint(0, populationSize div 2 - 1)]
      var child = crossover(parent1, parent2)
      mutate(child)
      newPopulation[i] = child

    population = newPopulation

  # Return the best individual found
  return population[0]

# Example usage
let bestSolution = geneticAlgorithm(100, 50)
echo "Best resource allocation: ", bestSolution.resources
echo "Best fitness score: ", bestSolution.fitness
