ThisBuild / version := "0.1.0-SNAPSHOT"

// 修改 Scala 版本为 2.12.15，这是 Chisel 支持的版本之一
ThisBuild / scalaVersion := "2.12.15"

lazy val root = (project in file("."))
  .settings(
        name := "lab3",
        idePackagePrefix := Some("com.yue"),
        // 添加 Chisel 依赖
        libraryDependencies += "edu.berkeley.cs" %% "chisel3" % "3.5.3",
        // 添加 Chisel 测试库依赖
        libraryDependencies += "edu.berkeley.cs" %% "chiseltest" % "0.5.3" % Test,
        // 添加 Chisel IOTesters 依赖，用于硬件测试
        libraryDependencies += "edu.berkeley.cs" %% "chisel-iotesters" % "1.5.1" % Test,
        // 添加编译器插件
        addCompilerPlugin("edu.berkeley.cs" %% "chisel3-plugin" % "3.5.3" cross CrossVersion.full)
  )