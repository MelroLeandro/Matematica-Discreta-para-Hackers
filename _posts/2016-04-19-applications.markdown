---
layout:     post
title:      "Typical Application"
author:     Mellean
tags: 		post applications problems multibody topology
subtitle:  	"Typical Applications and problems"
category:  ToyDIM
---
<!-- Start Writing Below in Markdown -->
# MULTIBODY SYSTEM: Typical Applications and problems
[source: MultiBody System SIMulation by Reinhold von Schwerin, Lecture Notes in Computational Science and Engineering 7.]

## Introduction
Multibody Systems play an important role in technical mechanics, game industry and bioinformatics. Major areas of application include
vehicle dynamics, robotics, biomechanics, heavy machinery, molecular dynamics and many more.

As is the case with modeling in general, multibody models aim at finding representations that reflect the reality of a machine or mechanism accurately enough for a given application. This assumes that this reality can be described in terms of characteristic quantities. This task can only be accomplished if challenging problems of numerical analysis have been solved beforehand and turned into well-designed scientific software.  The development of such mathematical soft-ware for multibody systems requires close interdisciplinary cooperation which also incorporates contributions from computer science.

## Classification of mechanical systems.

The main classes of models considered in mechanical engineering are

- continuous sytems, which consist of elastic bodies, for which mass and elasticity are continuously distributed throughout the body. The action of forces is also continuous along the body's surface.
- finite element systems, whose bodies are assumed to have nonzero mass and to be elastic with forces and moments acting at discrete points.
- multibody systems, whose bodies are assumed to have nonzero mass and to be rigid with forces and moments acting at discrete points.
- hybrid multi body systems, where both elastic and rigid bodies
are used to model a mechanical system.

## Multibody Systems

A multibody system is a collection of interconnected rigid bodies, which can move relative to one another, consistent with joints that limit relative motion of pairs of bodies. Forces and moments are caused by compliant elements like springs, dampers, actuators, or rods and other elements, that give rise to reaction forces and moments. This elements are generally assumed to be massless. The forces they apply on bodies of the system depend upon the position and relative velocity of the bodies.

The combination of various elements then yields a model which approximately describes the behavior of the mechanical system. The description is best suited for systems that undergo relatively large translational and rotational displacements

## Topology of multibody system
The motion of multibody systems is constrained in the sense that only relative motion of the bodies is possible according to the degrees of freedom permitted. Thus, while a free body in space has six degrees of freedom (three for translation and three for rotation), a body attached to some point in space via, e.g., a spherical joint only has the three rotational degrees of freedom left; the translational degrees of freedom are removed due to the geometry of the joint.

In order to analyze the kinematics and/or dynamics of a multibody system it is necessary to choose a suitable set of coordinates. From the above it is clear that by appropriately choosing six coordinates per body, the motion of the system can be described completely. However, in this case constraint equations which imply the geometry of the joints in the system (and are generally nonlinear) are needed. In particular, for regularity the constraint equations must not be redundant and there must be one equation for every degree of freedom taken out of mechanics.  



## Typical Applications in Technical Mechanics

The types of problems we face in the applications of multibody systems can be roughly classified as kinematic, dynamic, or optimization problems, all of which present challenges for the mathematician.
The general problem is either to find the positions of all the elements
of a multibody system given the values of certain drivers or input elements (forward kinematics) or the reverse (inverse kinematics).

Problems encountered in the analysis of this type of systems are:

- the assembly problem: This problem, also called the initial position problem, consists of finding the positions of all elements of the system once the values of the drivers are known. These positions must be in agreement with the constraint equations, which means that a nonlinear system of equations must be solved. If an overall position of the system is found which satisfies all the constraints, the position is said to be consistent. Usually here is generally a whole manifold of consistent solutions.

- the finite displacement problem:
This problem is related to the the assembly problem. The main difference is that the system starts from a consistent position and modifies the values of the input elements by a finite amount. The problem is then again to find a consistent set of positions, where one is interested usually in the one closest to the previous position.

- velocity and acceleration analysis:
Given the position and the velocities of the drivers, velocity anal-
ysis seeks to determine the velocities of the system bodies. Acceleration analysis consists of the computation of all accelerations given those of the drivers as well as all positions and velocities. These problems are linear and possess unique solutions.

- (forward) kinematic simulation:
Kinematic simulation encompasses all the problems mentioned before, the foremost being the finite displacement problem. By generating time histories of positions, velocities, and accelerations it is possible to view the whole range of motion of the system. The purpose of kinematic simulation is often to detect collisions or to study the trajectories of certain specified points.

- inverse kinematics:
The inverse kinematics problem is to find  velocities and accelerations which will produce given positions, velocities, accelerations of the system components. Particularly in robotics, this task usually means to find the joint variables which will result in a specific position (velocity, acceleration). Inverse kinematics is usually a subtask in (kinematic) optimization problems for multibody systems.

Forward kinematic problems are subtasks of dynamic simulation. In
particular, when dealing with descriptor systems, the problem of finding consistent initial values exists, this means that both the assembly problem and the problem of velocity analysis must be solved.

## Dynamic Problems

The characteristic of dynamic problems is that they involve forces as
well as the inertial properties of the bodies, namely their mass, inertial tensor and center of gravity. They are in general much more complicated than the kinematic problems; in fact, they mostly assume that the kinematic problems can be solved. Models of the dynamics of MBS typically include discontinuities in the state· variables or their time derivatives, which presents a particular challenge for mathematical methods for dynamic problems.

In practice the dynamic problems most commonly encountered are:
- the static equilibrium position problem:
Here one tries to find the position of the system in which all
forces are balanced. These problems are particularly hard to solve in the presence of discontinuities in the system equations and is fundamental for many application in bioinformatics like protein folding and drug development.

- the inverse dynamics problem:
The solution of the inverse dynamics problem answers the question as to what forces are necessary to produce a specified motion. This means that given the positions, velocities and accelerations of the system, the internal and external forces have to be computed. The most important application of inverse dynamics is that it determines the forces necessary to control a system in such a way that it will follow a desired trajectory with specified time history.

- the forward dynamics problem:
The forward dynamics problem has traditionally been at the heart of dynamic simulation. The problem is to find the accelerations of a system given the positions, the velocities, and the applied forces.

- the dynamic simulation problem
The solution to this problem yields the motion of a multibody system over a given time interval as a consequence of the applied forces and given initial conditions. It corresponds to the actual behavior of the system and to check it against measured data or compare it with some desired behavior. Therefore, its solution is the key to a proper design and modeling of a .

The dynamic simulation problem is the anchor point for our work and this project.
