1. msbuild command line:
   - /target:
   - /verbosity:minimal
2. DefaultTarget
3. Dependency specification:
   - DependsOnTargets
   - AfterTargets
   - BeforeTargets
   - CallTarget
4. Properties
   - property usage
   - setting from command line
   - no visibility control, _PropertyName convention for "not public" properties
5. Items
   - well known metadata with files
     http://msdn.microsoft.com/en-us/library/ms164313.aspx
   - metadata usage
   - concatenation
   - transformations
     http://msdn.microsoft.com/en-us/library/ms171476.aspx