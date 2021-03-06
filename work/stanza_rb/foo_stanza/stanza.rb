class FooStanza < TogoStanza::Stanza::Base
  property :greeting do
    'hello, world!'
  end

  property :features do |gene_id|
    query('http://togogenome.org/sparql', <<-SPARQL.strip_heredoc)
      PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
      PREFIX insdc: <http://ddbj.nig.ac.jp/ontologies/nucleotide/>
      SELECT DISTINCT ?feature_product ?feature_gene ?feature_gene_synonym
      WHERE {
        ?s rdfs:label "#{gene_id}" .
        ?s insdc:product ?feature_product .

        OPTIONAL {
          ?s insdc:gene  ?feature_gene .
          ?s insdc:gene_synonym  ?feature_gene_synonym .
        }
      }
    SPARQL
  end
end
