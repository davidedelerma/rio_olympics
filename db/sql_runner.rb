require('pg')

def run( sql )
  begin
    db = PG.connect({ dbname: 'rio_olympics', host: 'localhost' })
    result = db.exec( sql )
  ensure
    db.close
  end
  return result
end
