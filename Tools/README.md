# Tools and Snippets

### Workflow goes as follows:
Module => Tiles => Delay/offset => Render

Grid delay snippet:
```java
  for (int x = 0; x < div; x++) {
    for (int y = 0; y < div; y++) {
      float param = 5.0*(x+y)/div;
      module(2*scl*x, 2*scl*y, scl, sin(a+param));
    }
  }
```

Radial sort:
```java
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

List<PVector> modules = new ArrayList<PVector>();

for (int x = 0; x < div; x++) {
  for (int y = 0; y < div; y++) {
    modules.add(new PVector(2*scl*x, 2*scl*y));
  }
}

void sortPoints() {
  Collections.sort(modules, new Comparator<PVector>() {
    @Override
      public int compare(PVector lhs, PVector rhs) {
      double d1 = Math.hypot(lhs.x - width/2, lhs.y - height/2);
      double d2 = Math.hypot(rhs.x - width/2, rhs.y - height/2);
      return d1 < d2 ? -1 : (d1 == d2 ? 0 : 1);
    }
  }
  );
}
```

Radial delay:
```java
  for (int i = 0; i < modules.size(); i++) {
    float param = 5.0*i/modules.size();
    float x = modules.get(i).x;
    float y = modules.get(i).y;
    module(x, y, scl, cs(a+param)); 
  }
```
