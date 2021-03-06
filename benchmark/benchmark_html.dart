part of benchmark;

String shortHtml = "<p id='main'><a href='#'>This</a> is "
    "<em><strong>very</strong></em> interesting.</p>";

String longHtml = r"""
<h1>Package layout conventions</h1>
                <ol class="toc">
  <li><a href="#the-basics">The basics</a></li>
  <li><a href="#readme">README</a></li>
  <li><a href="#public-libraries">Public libraries</a></li>
  <li><a href="#public-assets">Public assets</a></li>
  <li><a href="#implementation-files">Implementation files</a></li>
  <li><a href="#web-files">Web files</a></li>
  <li><a href="#command-line-apps">Command-line apps</a></li>
  <li><a href="#tests-and-benchmarks">Tests and benchmarks</a></li>
  <li><a href="#documentation">Documentation</a></li>
  <li><a href="#examples">Examples</a></li>
  <li><a href="#internal-tools-and-scripts">Internal tools and scripts</a></li>
</ol>

<p>Part of a healthy code ecosystem is consistent conventions. When we all do the
same thing the same way, it makes it easier for us to learn our way around
each other&rsquo;s work. It also makes it easier to write tools that can automatically
do stuff for us.</p>

<p>When you build a Pub package, we have a set of conventions we encourage you to
follow. They describe how you organize the files and directories within your
package, and how to name things. You don&rsquo;t have to have every single thing
these guidelines specify. If your package doesn&rsquo;t have binaries, it doesn&rsquo;t
need a directory for them. But if it does, you&rsquo;ll make everyone&rsquo;s life easier
if you call it <code>bin</code>.</p>

<p>To give you a picture of the whole enchilada, here&rsquo;s what a complete package
(conveniently named <code>enchilada</code>) that uses every corner of these guidelines
would look like:</p>

<pre><code>enchilada/
  pubspec.yaml
  pubspec.lock *
  README.md
  LICENSE
  asset/
    guacamole.css
  benchmark/
    make_lunch.dart
    packages/ **
  bin/
    enchilada
    packages/ **
  doc/
    getting_started.md
  example/
    lunch.dart
    packages/ **
  lib/
    enchilada.dart
    tortilla.dart
    src/
      beans.dart
      queso.dart
  packages/ **
  test/
    enchilada_test.dart
    tortilla_test.dart
    packages/ **
  tool/
    generate_docs.dart
  web/
    index.html
    main.dart
    style.css
</code></pre>

<p>* The <code>pubspec.lock</code> will only be in source control if the package is an
<a href="glossary.html#application-package">application package</a>.</p>

<p>** The <code>packages</code> directories will exist locally after you&rsquo;re run
<code>pub get</code>, but won&rsquo;t be checked into source control.</p>

<h2 id="the-basics">The basics</h2>

<pre><code>enchilada/
  pubspec.yaml
  pubspec.lock
</code></pre>

<div class="learn-more">
  <a href="/doc/pubspec.html">
    Learn more about pubspecs &rarr;
  </a>
</div>

<p>Every package will have a <a href="pubspec.html"><strong>pubspec</strong></a>, a file named
<code>pubspec.yaml</code>, in the root directory of the package. That&rsquo;s what <em>makes</em> it a
package.</p>

<p>Once you&rsquo;ve run <a href="pub-get.html"><code>pub get</code></a> or <a href="pub-upgrade.html"><code>pub
upgrade</code></a> on the package, you will also have a <strong>lockfile</strong>,
named <code>pubspec.lock</code>. If your package is an <a href="glossary.html#application-package">application
package</a>, this will be checked into source
control. Otherwise, it won&rsquo;t be.</p>

<pre><code>enchilada/
  packages/
    ...
</code></pre>

<p>Running pub will also generate a <code>packages</code> directory. You will <em>not</em> check
this into source control, and you won&rsquo;t need to worry too much about its
contents. Consider it pub magic, but not scary magic.</p>

<p>The open source community has a few other files that commonly appear at the top
level of a project: <code>LICENSE</code>, <code>AUTHORS</code>, etc. If you use any of those, they can
go in the top level of the package too.</p>

<h2 id="readme">README</h2>

<pre><code>enchilada/
  README.md
</code></pre>

<p>One file that&rsquo;s very common in open source is a README file that
describes the project. This is especially important in pub. When you upload
to <a href="/">pub.dartlang.org</a>, your README will be shown on the page for your
package. This is the perfect place to introduce people to your code.</p>

<p>If your README ends in <code>.md</code>, <code>.markdown</code>, or <code>.mdown</code>, it will be parsed as
<a href="http://daringfireball.net/projects/markdown/">Markdown</a> so you can make it as fancy as you like.</p>

<h2 id="public-libraries">Public libraries</h2>

<pre><code>enchilada/
  lib/
    enchilada.dart
    tortilla.dart
</code></pre>

<p>Many packages are <a href="glossary.html#library-package"><em>library packages</em></a>: they
define Dart libraries that other packages can import and use. These public Dart
library files go inside a directory called <code>lib</code>.</p>

<p>Most packages define a single library that users can import. In that case,
its name should usually be the same as the name of the package, like
<code>enchilada.dart</code> in the example here. But you can also define other libraries
with whatever names make sense for your package.</p>

<p>When you do, users can import these libraries using the name of the package and
the library file, like so:</p>

<div class="highlight"><pre><code class="dart"><span class="k">import</span> <span class="s2">&quot;package:enchilada/enchilada.dart&quot;</span><span class="p">;</span>
<span class="k">import</span> <span class="s2">&quot;package:enchilada/tortilla.dart&quot;</span><span class="p">;</span>
</code></pre></div>

<p>If you feel the need to organize your public libraries, you can also create
subdirectories inside <code>lib</code>. If you do that, users will specify that path when
they import it. Say you have a file hierarchy like this:</p>

<pre><code>enchilada/
  lib/
    some/
      path/
        olives.dart
</code></pre>

<p>Users will import <code>olives.dart</code> like:</p>

<div class="highlight"><pre><code class="dart"><span class="k">import</span> <span class="s2">&quot;package:enchilada/some/path/olives.dart&quot;</span><span class="p">;</span>
</code></pre></div>

<p>Note that only <em>libraries</em> should be in <code>lib</code>. <em>Entrypoints</em>&mdash;Dart scripts
with a <code>main()</code> function&mdash;cannot go in <code>lib</code>. If you place a Dart script
inside <code>lib</code>, you will discover that any <code>package:</code> imports it contains don&rsquo;t
resolve. Instead, your entrypoints should go in the appropriate
<a href="glossary.html#entrypoint-directory">entrypoint directory</a>.</p>

<h2 id="public-assets">Public assets</h2>

<pre><code>enchilada/
  asset/
    guacamole.css
</code></pre>

<p>While most library packages exist to let you reuse Dart code, you can also
reuse other kinds of content. For example, a package for something like
<a href="http://getbootstrap.com/">Bootstrap</a> might include a number of CSS files for
consumers of the package to use.</p>

<p>These go in a top-level directory named <code>asset</code>. You can put any kind of file
in there and organize it with subdirectories however you like. It&rsquo;s effectively
a <code>lib</code> directory for stuff that isn&rsquo;t Dart code.</p>

<p>Users can reference another package&rsquo;s assets using URLs that contain
<code>assets/&lt;package&gt;/&lt;path&gt;</code> where <code>&lt;package&gt;</code> is the name of the package
containing the asset and <code>&lt;path&gt;</code> is the relative path to the asset within that
package&rsquo;s <code>asset</code> directory.</p>

<aside class="alert alert-warning">

<p>The mechanics of referencing assets are still being implemented. URLs that
contain <tt>assets/</tt> are handled by <a href="pub-serve.html"><tt>pub
serve</tt></a>.</p>

<p>The <a href="pub-build.html"><tt>pub build</tt></a> command also copies
assets to an <tt>assets</tt> directory, but this will <em>only</em> be in the
root directory of the output, so you must make sure that your <tt>assets/</tt>
URL correctly resolves to that directory and not a subdirectory.</p>

<p>We don't currently have a solution for referencing assets in command-line
Dart applications.</p>

</aside>

<p>Note that <code>assets</code> is plural in the URL. This is a bit like the split between
<code>lib</code> and <code>packages</code>. The former is the name of the <em>directory in the package</em>,
the latter is the <em>name you use to reference it</em>.</p>

<p>For example, let&rsquo;s say your package wanted to use enchilada&rsquo;s <code>guacamole.css</code>
styles. In an HTML file in your package, you can add:</p>

<div class="highlight"><pre><code class="html"><span class="nt">&lt;link</span> <span class="na">href=</span><span class="s">&quot;assets/enchilada/guacamole.css&quot;</span> <span class="na">rel=</span><span class="s">&quot;stylesheet&quot;</span><span class="nt">&gt;</span>
</code></pre></div>

<p>When you run your application using <a href="pub-serve.html"><code>pub serve</code></a>, or build it
to something deployable using <a href="pub-build.html"><code>pub build</code></a>, Pub will copy over
any referenced assets that your package depends on.</p>

<h2 id="implementation-files">Implementation files</h2>

<pre><code>enchilada/
  lib/
    src/
      beans.dart
      queso.dart
</code></pre>

<p>The libraries inside &ldquo;lib&rdquo; are publicly visible: other packages are free to
import them. But much of a package&rsquo;s code is internal implementation libraries
that should only be imported and used by the package itself. Those go inside a
subdirectory of <code>lib</code> called <code>src</code>. You can create subdirectories in there if
it helps you organize things.</p>

<p>You are free to import libraries that live in <code>lib/src</code> from within other Dart
code in the <em>same</em> package (like other libraries in <code>lib</code>, scripts in <code>bin</code>, and
tests) but you should never import from another package&rsquo;s <code>lib/src</code> directory.
Those files are not part of the package&rsquo;s public API, and they might change in
ways that could break your code.</p>

<p>When you use libraries from within your own package, even stuff in <code>src</code>, you
can (and should) still use <code>"package:"</code> to import them. This is perfectly
legit:</p>

<div class="highlight"><pre><code class="dart"><span class="k">import</span> <span class="s2">&quot;package:enchilada/src/beans.dart&quot;</span><span class="p">;</span>
</code></pre></div>

<p>The name you use here (in this case <code>enchilada</code>) is the name you specify for
your package in its <a href="pubspec.html">pubspec</a>.</p>

<h2 id="web-files">Web files</h2>

<pre><code>enchilada/
  web/
    index.html
    main.dart
    style.css
</code></pre>

<p>Dart is a web language, so many pub packages will be doing web stuff. That
means HTML, CSS, images, and, heck, probably even some JavaScript. All of that
goes into your package&rsquo;s <code>web</code> directory. You&rsquo;re free to organize the contents
of that to your heart&rsquo;s content. Go crazy with subdirectories if that makes you
happy.</p>

<p>Also, and this is important, any Dart web entrypoints (in other words, Dart
scripts that are referred to in a <code>&lt;script&gt;</code> tag) go under <code>web</code> and not <code>lib</code>.
That ensures that there is a nearby <code>packages</code> directory so that <code>package:</code>
imports can be resolved correctly.</p>

<p>(You may be asking yourself, &ldquo;Self, where should I put my web-based example
programs? <code>example</code> or <code>web</code>?&rdquo; Put those in <code>example</code>.)</p>

<h2 id="command-line-apps">Command-line apps</h2>

<pre><code>enchilada/
  bin/
    enchilada
</code></pre>

<p>Some packages define programs that can be run directly from the command line.
These can be shell scripts or any other scripting language, including Dart.
The <code>pub</code> application itself is one example: it&rsquo;s a simple shell script that
invokes <code>pub.dart</code>.</p>

<p>If your package defines stuff like this, put it in a directory named <code>bin</code>.</p>

<aside class="alert alert-note">

At some point, pub will support automatically adding that directory to your
system path so that these scripts can be easily invoked.

</aside>

<h2 id="tests-and-benchmarks">Tests and benchmarks</h2>

<pre><code>enchilada/
  test/
    enchilada_test.dart
    tortilla_test.dart
</code></pre>

<p>Every self-respecting package should have tests. With pub, the convention is
that these go in a <code>test</code> directory (or some directory inside it if you like)
and have <code>_test</code> at the end of their file names.</p>

<p>Typically, these use the <a href="http://api.dartlang.org/unittest.html">unittest</a>
package but you can use whatever testing system that gets you excited.</p>

<pre><code>enchilada/
  benchmark/
    make_lunch.dart
</code></pre>

<p>Packages that have performance critical code may also include <em>benchmarks</em>.
These test the API not for correctness but for speed (or memory use, or maybe
other empirical metrics).</p>

<h2 id="documentation">Documentation</h2>

<pre><code>enchilada/
  doc/
    getting_started.md
</code></pre>

<p>If you&rsquo;ve got code and tests, the next piece you need to maximize your karma
is good documentation. That goes inside a directory named <code>doc</code>. We don&rsquo;t
currently have any guidelines about format or organization within that. Use
whatever markup format you like and be happy that you&rsquo;re actually writing docs.</p>

<p>This directory should <em>not</em> just contain docs generated automatically from your
source code using
<a href="http://api.dartlang.org/docs/continuous/dartdoc.html">dartdoc</a>. Since that&rsquo;s
pulled directly from the code already in the package, putting those docs in
here would be redundant. Instead, this is for tutorials, guides, and other
hand-authored documentation <em>in addition to</em> generated API references.</p>

<h2 id="examples">Examples</h2>

<pre><code>enchilada/
  example/
    lunch.dart
</code></pre>

<p>At this point, you&rsquo;re going for the brass ring. Code, tests, docs, what else
could your users want? Standalone example programs that use your package, of
course! Those go inside the <code>example</code> directory. If the examples are complex
and use multiple files, consider making a directory for each example. Otherwise,
you can place each one right inside <code>example</code>.</p>

<p>This is an important place to consider using <code>package:</code> to import files from
your own package. That ensures the example code in your package looks exactly
like code outside of your package would look.</p>

<h2 id="internal-tools-and-scripts">Internal tools and scripts</h2>

<pre><code>enchilada/
  tool/
    generate_docs.dart
</code></pre>

<p>Mature packages often have little helper scripts and programs that people
run while developing the package itself. Think things like test runners,
documentation generators, or other bits of automation.</p>

<p>Unlike the scripts in <code>bin</code>, these are <em>not</em> for external users of the package.
If you have any of these, place them in a directory called <code>tool</code>.</p>
""";
